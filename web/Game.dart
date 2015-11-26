part of animations;

class Game extends Engine {
    List<Renderable> renderables = new List<Renderable>();

    Game({int x, int y}) {
        this.x = x;
        this.y = y;
        setSize(x, y);
    }

    void _render(num time) {
        _clearCanvas();
    	renderables.forEach((renderable){
            renderable.render(context2D, time);
    	});
    }

    void addRenderable(Renderable renderable) {
        renderables.add(renderable);
    }

    Fighter addFighter(num xPos, num yPos) {
    	Fighter f = new Fighter(x: xPos, y: yPos);
    	addRenderable(f);
        return f;
    }

}
