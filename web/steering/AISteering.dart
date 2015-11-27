part of animations;

class AIEnvironment {
    Game game;
    int visibilityDistance = 100;

    AIEnvironment(this.game);

    int getFieldX() => game.x;
    int getFieldY() => game.y;

    Map<num, Fighter> getVisibleFighter(Fighter fighter) {
        Map<num, Fighter> visibileFighters = new Map<num, Fighter>();
        game.fighters.forEach((unkownFighter){
            if (unkownFighter != fighter) {
                num distance = fighter.getDistanceTo(unkownFighter);
                if (distance <= visibilityDistance) {
                    visibileFighters[distance] = unkownFighter;
                }
            }
        });
        return visibileFighters;
    }
}

class AISteering extends SteeringConnector implements Renderable {

    AIEnvironment environment;
    Fighter fighter;

    AISteering(Fighter fighter, this.environment) : super(fighter){
        this.fighter = fighter;
        environment.game.addRenderable(this);
        /*moveForwardStart / moveForwardStop
        moveBackwardStart / moveBackwardStop
        leftStart / leftStop
        rightStart / rightStop
        fireStart / fireStop*/

    }

    void render(CanvasRenderingContext2D context2D, num delta) {

        _renderVisibilityDistance(context2D, delta);
    }

    void _renderVisibilityDistance(CanvasRenderingContext2D context2D, num delta){
        context2D.beginPath();
        context2D.arc(
            fighter.x, fighter.y,
            environment.visibilityDistance,
            0, 2*Math.PI
        );
        context2D.stroke();

        Map<num, Fighter> visibileFighter = environment.getVisibleFighter(fighter);
        num smallest;
        for (var distance in visibileFighter.keys) {
            if (smallest == null) {
                smallest = distance;
            } else {
                if (distance < smallest) {
                    smallest = distance;
                }
            }
        }
        if (smallest != null) {
            Fighter nearestFighter = visibileFighter[smallest];
            context2D.beginPath();
            context2D.moveTo(fighter.x, fighter.y);
            context2D.lineTo(nearestFighter.x, nearestFighter.y);
            context2D.stroke();
        }

    }
}
