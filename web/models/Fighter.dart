part of animations;

class Fighter implements Renderable{
    num x = 2.0;
    num y = 2.0;

    num headRadius = 10;

    Circle head;
    Circle leftArm;
    Circle rightArm;
    Bullet bullet;
    num bulletRange = 300;

    num rotate = 90;
    num rotationSpeed = 180;
    num rotateTo = 90;
    bool rotating = false;

    num moveToX = 2.0;
    num moveToY = 2.0;
    num moveSpeed = 1.5;
    bool moving = false;

    String headFillColor = 'red';
    String leftArmFillColor = '#B90000';
    String rightArmFillColor = '#FF4F4F';

    Fighter({this.x, this.y}){
        head = new Circle(x: x, y: y, r: headRadius);
        leftArm = new Circle(x: x+headRadius, y: y, r: headRadius/2);
        rightArm = new Circle(x: x-headRadius, y: y, r: headRadius/2);

        head.lineWidth = 0.5;
        head.fillColor = headFillColor;
        leftArm.fillColor = leftArmFillColor;
        rightArm.fillColor = rightArmFillColor;
    }

    void render(CanvasRenderingContext2D context2D, num delta) {
        _renderBody(context2D, delta);
        _renderOrientationStroke(context2D, delta);
        _renderBullets(context2D, delta);

        _calculateRotating(delta);
        _calculateMoving(delta);
    }

    void _renderBody(CanvasRenderingContext2D context2D, num delta) {
        num radLeft = (2*Math.PI*(rotate-90)) / 360;
        num radRight = (2*Math.PI*(rotate+90)) / 360;

        leftArm.x = x+(headRadius*Math.cos(radLeft));
        leftArm.y = y+(headRadius*Math.sin(radLeft));
        leftArm.render(context2D, delta);

        rightArm.x = x+(headRadius*Math.cos(radRight));
        rightArm.y = y+(headRadius*Math.sin(radRight));
        rightArm.render(context2D, delta);

        head.x = x;
        head.y = y;
        head.render(context2D, delta);
    }

    void _renderOrientationStroke(CanvasRenderingContext2D context2D, num delta) {
       num radHead = (2*Math.PI*rotate) / 360;
       context2D.beginPath();
       context2D.moveTo(x,y);
       context2D.lineTo(x+(headRadius*Math.cos(radHead)), y+(headRadius*Math.sin(radHead)));
       context2D.stroke();
    }

    void _renderBullets(CanvasRenderingContext2D context2D, num delta) {
        if (bullet != null) {
            bullet.render(context2D, delta);
            if (bullet.finished) {
                bullet = null;
            }
        }
    }

    void _calculateRotating(num delta) {
        if (rotate != rotateTo) {
    	    rotating = true;
            rotate += (rotationSpeed) / delta;
            print('rotate: '+rotate.toString());
            if (rotate > rotateTo) {
                rotate = rotateTo;
            }
        } else {
            rotating = false;
    	}
    }

    void _calculateMoving(num delta) {
        if (x != moveToX || y != moveToY) {
    	    moving = true;
    	    if (x != moveToX) {
                if (moveToX-x < 0) {
        		    x += 1;
        		    if (x > moveToX) {
        			x = moveToX;
        		    }
        		} else {
        		    x -= 1;
        		    if (x < moveToX) {
        			x = moveToX;
        		    }
        		}
    	    }

            if (y != moveToY) {
                if (moveToY-y < 0) {
                    y += 1;
                    if (y > moveToY) {
                        y = moveToY;
                    }
        		} else {
        		    y -= 1;
                    if (y < moveToY) {
                        y = moveToY;
                    }
        		}
    	    }
    	} else {
    	    moving = false;
    	}
    }

    void fire() {
        if (bullet == null) {
            num rad = (2*Math.PI*rotate) / 360;
            bullet = new Bullet(
                from_x: x, from_y: y,
                to_x: x+((headRadius+bulletRange)*Math.cos(rad)),
                to_y: y+((headRadius+bulletRange)*Math.sin(rad)),
                r:2, speed: 500/1000
            );
        }
    }

    void toRotate(num newRotateTo) {
        rotateTo = newRotateTo;
        print('toRotate: '+rotateTo.toString());
    }

    void rotateLeft() {
        rotateTo = rotate - 5;
    }
    void rotateRight() {
        rotateTo = rotate + 5;
    }

    void moveForward() {
        num rad = (2*Math.PI*rotate) / 360;
        moveToX = x+((moveSpeed)*Math.cos(rad));
        moveToY = y+((moveSpeed)*Math.sin(rad));
    }

    void moveBackward() {
        num rad = (2*Math.PI*rotate) / 360;
        moveToX = x-((moveSpeed)*Math.cos(rad));
        moveToY = y-((moveSpeed)*Math.sin(rad));
    }
}
