library animations;

import 'dart:html';
import 'dart:math' as Math;
// import 'dart:async';

part 'Engine.dart';
part 'Game.dart';

void main() {
    Game game = new Game(
        x: 500, y: 500
    );

    DivElement rotationValue = new DivElement();
    ButtonElement fire = new ButtonElement();
    fire.text = "fire";
    fire.onClick.listen((e){
        game.fighter.fire();
    });
    InputElement fighterRotation = new InputElement();
    fighterRotation.type = "range";
    fighterRotation.min = "0";
    fighterRotation.max = "360";
    fighterRotation.step = "1";
    fighterRotation.value = "0";
    fighterRotation.onInput.listen((e){
        game.fighter.toRotate(int.parse(fighterRotation.value));
        rotationValue.text = fighterRotation.value;
    });
    document.body.nodes.add(fighterRotation);
    document.body.nodes.add(rotationValue);
    document.body.nodes.add(fire);

    game.fighter.toRotate(0);
    game.start();
}
