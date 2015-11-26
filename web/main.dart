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
    Fighter user = game.addFighter(100, 100);
    game.addFighter(200, 200);

    document.body.onKeyDown.listen((e){
    	var keyEvent = new KeyEvent.wrap(e);
        switch(keyEvent.keyCode){
            case keyUp:
                user.moveForward(true);
                break;
            case keyDown:
                user.moveBackward(true);
                break;
            case keyLeft:
                user.rotateLeft(true);
                break;
            case keyRight:
                user.rotateRight(true);
                break;
            case keyFire:
                user.fire(true);
                break;
        }
    });

    document.body.onKeyUp.listen((e){
        var keyEvent = new KeyEvent.wrap(e);
        switch(keyEvent.keyCode){
            case keyUp:
                user.moveForward(false);
                break;
            case keyDown:
                user.moveBackward(false);
                break;
            case keyLeft:
                user.rotateLeft(false);
                break;
            case keyRight:
                user.rotateRight(false);
                break;
            case keyFire:
                user.fire(false);
                break;
        }
    });

    game.start();
}
