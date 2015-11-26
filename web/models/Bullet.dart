part of animations;

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
