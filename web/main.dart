library animations;

import 'dart:html';
import 'dart:math' as Math;
// import 'dart:async';

part 'steering/SteeringConnector.dart';
part 'steering/KeyboardSteering.dart';
part 'models/Renderable.dart';
part 'models/Bullet.dart';
part 'models/Circle.dart';
part 'models/Fighter.dart';
part 'Engine.dart';
part 'Game.dart';

void main() {
    Game game = new Game(x: 500, y: 500);

    Fighter user = game.addFighter(100, 100);
    Fighter opponent = game.addFighter(200, 200);

    new KeyboardSteering(user);
    new KeyboardSteering(opponent, up: 38, down: 40, left: 37, right:39, fire: 96);

    game.start();
}
