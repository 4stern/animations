part of animations;

abstract class Renderable {
    void render(CanvasRenderingContext2D context2D, num delta);
}

class Circle implements Renderable{
    num x = 0.0;
    num y = 0.0;
    num r = 1;

    String fillColor = 'white';
    String strokeColor = 'black';
    num lineWidth = 1;

    Circle({this.x, this.y, this.r});

    void render(CanvasRenderingContext2D context2D, num delta) {
        context2D.beginPath();
        context2D.arc(x, y, r, 0, 2*Math.PI);
        context2D.fillStyle = fillColor;
        context2D.fill();
        context2D.lineWidth = lineWidth;
        context2D.strokeStyle = strokeColor;
        context2D.stroke();
    }
}

class Bullet implements Renderable{
    num from_x = 0.0;
    num from_y = 0.0;
    num to_x = 0.0;
    num to_y = 0.0;

    num current_x = 0.0;
    num current_y = 0.0;

    num len_x = 0.0;
    num len_y = 0.0;

    int r = 1;

    bool finished = false;

    num speed = 500 / 1000; // px per second

    Bullet({this.from_x, this.from_y, this.to_x, this.to_y, this.r, this.speed}) {
        current_x = from_x;
        current_y = from_y;

        len_x = to_x - from_x;
        len_y = to_y - from_y;
    }

    void render(CanvasRenderingContext2D context2D, num delta) {
        if (finished==false) {
            context2D.beginPath();
            context2D.arc(current_x, current_y, r, 0, 2*Math.PI);
            context2D.stroke();
            _calcNewPos(delta);
        }
    }

    void _calcNewPos(num delta) {
        //calculate the new position
        if (to_x != from_x) {
            current_x += (len_x*speed) / delta;
        }
        if (to_y != from_y) {
            current_y += (len_y*speed) / delta;
        }

        // detect reached target
        if (to_x - from_x > 0) {
            if (current_x > to_x) {
                current_x = to_x;
            }
        } else {
            if (current_x < to_x) {
                current_x = to_x;
            }
        }
        if (to_y - from_y > 0) {
            if (current_y > to_y) {
                current_y = to_y;
            }
        } else {
            if (current_y < to_y) {
                current_y = to_y;
            }
        }

        if (current_y == to_y && current_x == to_x) {
            finished = true;
        }
    }
}

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

class Game extends Engine {

    // Circle c = new Circle(x:20.0, y:20.0, r:4);
    // Bullet b = new Bullet(
    //     from_x: 300, from_y: 300,
    //     to_x: 20, to_y: 30,
    //     r:2, speed: 500/1000);

    Fighter fighter = new Fighter(x: 100, y: 100);

    Game({int x, int y}) {
        this.x = x;
        this.y = y;
        setSize(x, y);
    }

    // int b_counter = 0;
    void _render(num time) {
        _clearCanvas();

        // c.render(context2D, time);
        // b.render(context2D, time);
        fighter.render(context2D, time);
        // if (b.finished) {
        //     b_counter++;
        //     b = new Bullet(
        //         from_x: 300, from_y: 300,
        //         to_x: 20, to_y: 30,
        //         r:2, speed: 800/1000);
        // }
    }
}
