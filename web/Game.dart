part of animations;

class Game extends Engine {

    // Circle c = new Circle(x:20.0, y:20.0, r:4);
    // Bullet b = new Bullet(
    //     from_x: 300, from_y: 300,
    //     to_x: 20, to_y: 30,
    //     r:2, speed: 500/1000);

    Fighter fighter;
    List<Renderables> renderables = new List<Renderables>();

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
        //fighter.render(context2D, time);
        // if (b.finished) {
        //     b_counter++;
        //     b = new Bullet(
        //         from_x: 300, from_y: 300,
        //         to_x: 20, to_y: 30,
        //         r:2, speed: 800/1000);
        // }
	renderables.forEach((renderable){
            renderable.render(context2D, time);
	});
    }

    void addRenderable(Renderable renderable) {
	renderables.add(renderable);
    }

    void addFighter(num xPos, num yPos) {
	Fighter f = new Fighter(x: xPos, y: yPos);
	f.toRotate(0);
	if (fighter == null) {
		fighter = f;
	}
	addRenderable(f);
    }

}
