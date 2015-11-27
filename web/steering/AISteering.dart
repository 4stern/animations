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

class NavigationPoint {
    num x;
    num y;
    NavigationPoint(this.x, this.y);
}

class AISteering extends SteeringConnector implements Renderable {

    AIEnvironment environment;
    Fighter fighter;
    List<NavigationPoint> path = new List<NavigationPoint>();
    Fighter target;

    AISteering(Fighter fighter, this.environment) : super(fighter){
        this.fighter = fighter;
        environment.game.addRenderable(this);
        /*moveForwardStart / moveForwardStop
        moveBackwardStart / moveBackwardStop
        leftStart / leftStop
        rightStart / rightStop
        fireStart / fireStop*/

        /*path.add(new NavigationPoint(150,150));
        path.add(new NavigationPoint(400,400));
        path.add(new NavigationPoint(350,250));*/
    }

    void render(CanvasRenderingContext2D context2D, num delta) {
        _handlePathMoving(context2D, delta);

        // d3buging informations
        _renderVisibilityDistance(context2D, delta);
    }

    NavigationPoint _getCurrentNavigationPoint() {
        return path.length > 0 ? path[0] : null;
    }

    void _handlePathMoving(CanvasRenderingContext2D context2D, num delta) {
        NavigationPoint navigationPoint = _getCurrentNavigationPoint();
        if (navigationPoint != null) {

            num nx = navigationPoint.x;
            num ny = navigationPoint.y;
            num fx = fighter.x;
            num fy = fighter.y;

            if (fighter.getDistanceToNav(navigationPoint) < 1) {
                path.remove(navigationPoint);
                moveForwardStop();

            } else if (target != null) {
                num distance = target.getDistanceTo(fighter);
                num visibilityDistance = environment.visibilityDistance;
                _rotateToTargetAt(target.x, target.y);
                if (distance > visibilityDistance) {
                    fireStop();
                    if (distance > visibilityDistance*1.5) {
                        target = null;
                        moveForwardStop();
                    } else {
                        moveForwardStart();
                    }

                } else {
                    if (navigationPoint != null) {
                        path.remove(navigationPoint);
                        moveForwardStop();
                    }
                    fireStart();
                }
            } else {
                moveForwardStart();
                Circle c = new Circle(x: nx, y:ny, r:2);
                c.fillColor = "green";
                c.strokeColor = "green";
                c.render(context2D, delta);

                _rotateToTargetAt(nx, ny);
                target = _getTarget();
            }
        } else {
            _findNextNavigationPoint();
        }
    }

    void _rotateToTargetAt(num nx, num ny) {
        num fx = fighter.x;
        num fy = fighter.y;
        num rx = fx+((fighter.headRadius+100)*Math.cos(0));
        num ry = fy+((fighter.headRadius+100)*Math.sin(0));
        num AB_x = rx - fx;
        num AB_y = ry - fy;
        num CD_x = nx - fx;
        num CD_y = ny - fy;

        num ort =
            (
                (AB_x * CD_x) + (AB_y * CD_y)
            )
                /
            (
                Math.sqrt(Math.pow(AB_x, 2) + Math.pow(AB_y, 2)) *
                Math.sqrt(Math.pow(CD_x, 2) + Math.pow(CD_y, 2))
            );
            print('ort: '+ort.toString());
        num newRotation = Math.acos(ort) / Math.PI * 180.0;
        num newRotation2 = 360 - newRotation;

        if (ny > fy) {
            newRotation2 = newRotation;
        }

        print('rotations: '+newRotation.toString()+' / ' +newRotation2.toString());
        fighter.toRotate(newRotation2);
    }

    Fighter _getTarget() {
        Fighter nearestFighter;
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
            nearestFighter = visibileFighter[smallest];
        }
        return nearestFighter;
    }

    void _findNextNavigationPoint() {
        var rng = new Math.Random();
        path.add(new NavigationPoint(
            rng.nextInt(environment.getFieldX()),
            rng.nextInt(environment.getFieldY())
        ));
    }

    void _renderVisibilityDistance(CanvasRenderingContext2D context2D, num delta) {
        context2D.beginPath();
        context2D.strokeStyle="green";
        context2D.arc(
            fighter.x, fighter.y,
            environment.visibilityDistance,
            0, 2*Math.PI
        );
        context2D.stroke();
    }
}
