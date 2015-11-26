library animations;

import 'dart:html';
import 'dart:math' as Math;
// import 'dart:async';
part 'models/Renderable.dart';
part 'models/Bullet.dart';
part 'models/Circle.dart';
part 'models/Fighter.dart';
part 'Engine.dart';
part 'Game.dart';

void main() {

    const int keyUp = 87; // w
    const int keyDown = 83 ; // s
    const int keyLeft = 65; // a
    const int keyRight = 68; // d
    const int keyFire = 32; // space

    Game game = new Game(
        x: 500, y: 500
    );
    game.addFighter(100, 100);
    game.addFighter(200, 200);

    DivElement rotationValue = new DivElement();
    ButtonElement fire = new ButtonElement();
    fire.text = "fire";
    fire.onClick.listen((e){
        game.fighter.fire();
    });
    InputElement fighterRotation = new InputElement();
    fighterRotation.type = "range";
    fighterRotation.min = "0";
    fighterRotation.max = "1080";
    fighterRotation.step = "1";
    fighterRotation.value = "0";
    fighterRotation.onInput.listen((e){
        game.fighter.toRotate(int.parse(fighterRotation.value));
        rotationValue.text = fighterRotation.value;
    });

    ButtonElement move = new ButtonElement();
    move.text = "move";
    move.onClick.listen((e){
        game.fighter.moveForward();
    });

    document.body.onKeyDown.listen((e){
    	var keyEvent = new KeyEvent.wrap(e);
        switch(keyEvent.keyCode){
            case keyUp:
                game.fighter.moveForward(true);
                break;
            case keyDown:
                game.fighter.moveBackward(true);
                break;
            case keyLeft:
                game.fighter.rotateLeft(true);
                break;
            case keyRight:
                game.fighter.rotateRight(true);
                break;
            case keyFire:
                game.fighter.fire();
                break;
        }
    });

    document.body.onKeyUp.listen((e){
        var keyEvent = new KeyEvent.wrap(e);
        switch(keyEvent.keyCode){
            case keyUp:
                game.fighter.moveForward(false);
                break;
            case keyDown:
                game.fighter.moveBackward(false);
                break;
            case keyLeft:
                game.fighter.rotateLeft(false);
                break;
            case keyRight:
                game.fighter.rotateRight(false);
                break;
            case keyFire:
                game.fighter.fire();
                break;
        }
    });


    document.body.nodes.add(fighterRotation);
    document.body.nodes.add(rotationValue);
    document.body.nodes.add(fire);
    document.body.nodes.add(move);

    game.start();
}
