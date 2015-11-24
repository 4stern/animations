part of animations;

abstract class Engine {
    CanvasElement canvas = new CanvasElement();
    CanvasRenderingContext2D context2D;

    bool runs = false;
    List<Function> loops = new List<Function>();
    num lastFrameTime = 0;

    int x;
    int y;

    Engine() {
        document.body.nodes.add(canvas);
        context2D = canvas.context2D;
        window.requestAnimationFrame(_update);
    }

    void start() {
        if (runs == false) {
            runs = true;
        }
    }

    void stop() {
        if (runs == true) {
            runs = false;
        }
    }

    void _update(num time) {
        num deltaTime = time - lastFrameTime;

        if (runs == true) {
            _render(deltaTime);
        }

        lastFrameTime = time;
        window.requestAnimationFrame(_update);
    }

    void setSize(int x, int y) {
        canvas.width = x;
        canvas.height = y;
    }

    void _clearCanvas() {
        context2D.clearRect(0, 0, x, y);
    }

    void _render(num time){}
}
