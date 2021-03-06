part of animations;

class Game extends Engine {
    List<Renderable> renderables = new List<Renderable>();
    List<Fighter> fighters = new List<Fighter>();

    Game({int x, int y}) {
        this.x = x;
        this.y = y;
        setSize(x, y);
    }

    void _render(num time) {
        _clearCanvas();
        context2D.fillStyle = "#D0D0D0";
        context2D.fillRect(0,0,x,y);
    	renderables.forEach((renderable){
            renderable.render(context2D, time);
    	});
    }

    void addRenderable(Renderable renderable) {
        renderables.add(renderable);
    }

    Fighter addFighter(num xPos, num yPos, {String color, num speed}) {
    	Fighter f = new Fighter(x: xPos, y: yPos);
        if (color != null) {
            f.headFillColor = color;
            f.leftArmFillColor = color;
            f.rightArmFillColor = color;
        }
        if (speed != null) {
            f.moveSpeed = speed;
        }
        fighters.add(f);
    	addRenderable(f);
        return f;
    }

}
