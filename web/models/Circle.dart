part of animations;

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
