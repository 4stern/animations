library animations;

import 'dart:html';
import 'dart:math' as Math;
// import 'dart:async';

part 'steering/SteeringConnector.dart';
part 'steering/KeyboardSteering.dart';
part 'steering/AISteering.dart';
part 'models/Renderable.dart';
part 'models/Bullet.dart';
part 'models/Circle.dart';
part 'models/Fighter.dart';
part 'Engine.dart';
part 'Game.dart';

void main() {
    Game game = new Game(x: 500, y: 500);

    Fighter user = game.addFighter(100, 100, color: "red", speed: 2.0);
    Fighter opponent = game.addFighter(400, 400, color: "blue", speed: 1.0);

    new KeyboardSteering(user);
    new KeyboardSteering(opponent, up: 38, down: 40, left: 37, right:39, fire: 96);
    AISteering ai = new AISteering(opponent, new AIEnvironment(game));

    game.start();
    user.moveTo(100, 100);
    opponent.moveTo(400, 400);

    var clientRect = game.canvas.getBoundingClientRect();
    print(clientRect);
    game.canvas.onClick.listen((MouseEvent e){
        print(e);
        for (var key in e) {
            print(e[key]);
        }
        var x = e.clientX - clientRect.left;
        var y = e.clientY - clientRect.top;
        ai.path.add(new NavigationPoint(x, y));
    });
}
