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

    int counter = 0;
    void render(CanvasRenderingContext2D context2D, num delta) {
        num radHead = (2*Math.PI*rotate) / 360;
        num radLeft = (2*Math.PI*(rotate-90)) / 360;
        num radRight = (2*Math.PI*(rotate+90)) / 360;

        leftArm.x = x+(headRadius*Math.cos(radLeft));
        leftArm.y = y+(headRadius*Math.sin(radLeft));
        leftArm.render(context2D, delta);

        rightArm.x = x+(headRadius*Math.cos(radRight));
        rightArm.y = y+(headRadius*Math.sin(radRight));
        rightArm.render(context2D, delta);

        head.render(context2D, delta);


        context2D.beginPath();
        context2D.moveTo(x,y);
        context2D.lineTo(x+(headRadius*Math.cos(radHead)), y+(headRadius*Math.sin(radHead)));
        context2D.stroke();

        if (bullet != null) {
            bullet.render(context2D, delta);
            if (bullet.finished) {
                bullet = null;
            }
        }

        if (rotate != rotateTo) {
            rotate += (rotationSpeed) / delta;
            print('rotate: '+rotate.toString());
            if (rotate > rotateTo) {
                rotate = rotateTo;
            }
        }
    }

    void fire() {
        if (bullet == null) {
            num rad = (2*Math.PI*rotate) / 360;
            bullet = new Bullet(
                from_x: x, from_y: y,
                to_x: x+((headRadius+bulletRange)*Math.cos(rad)),
                to_y: y+((headRadius+bulletRange)*Math.sin(rad)),
                r:2, speed: 500/1000);
        }
    }

    void toRotate(num newRotateTo) {
        rotateTo = newRotateTo;
        print('toRotate: '+rotateTo.toString());
    }
}
