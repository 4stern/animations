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
                game.fighter.fire(true);
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
                game.fighter.fire(false);
                break;
        }
    });

    game.start();
}
