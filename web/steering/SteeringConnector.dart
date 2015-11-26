part of animations;

abstract class SteeringConnector {

    Fighter fighter;

    SteeringConnector(this.fighter);

    void moveForwardStart() {
        fighter.moveForward(true);
    }
    void moveForwardStop() {
        fighter.moveForward(false);
    }
    void moveBackwardStart() {
        fighter.moveBackward(true);
    }
    void moveBackwardStop() {
        fighter.moveBackward(false);
    }
    void leftStart() {
        fighter.rotateLeft(true);
    }
    void leftStop() {
        fighter.rotateLeft(false);
    }
    void rightStart() {
        fighter.rotateRight(true);
    }
    void rightStop() {
        fighter.rotateRight(false);
    }
    void fireStart() {
        fighter.fire(true);
    }
    void fireStop() {
        fighter.fire(false);
    }
}
