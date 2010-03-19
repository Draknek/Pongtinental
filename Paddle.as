package
{
	import flash.display.*;
	import flash.events.*;
	
	public class Paddle extends Shape
	{
		public var size: Number = 30;
		public var speed: Number = 5;
		
		public var vy: Number;
		
		private var game: Game;
		
		private var controller: Controller;
		
		public function Paddle (_x: Number, _game: Game)
		{
			graphics.lineStyle(4, 0x00FF00);
			graphics.moveTo(0, -size);
			graphics.lineTo(0, size);
			
			game = _game;
			
			x = _x;
			y = 240;
			
			controller = Controller.create(this, game);
		}
		
		public function update (): void
		{
			vy = controller.getDirection() * speed;
			
			y += vy;
			
			if (y - size < 0) { y = size; }
			if (y + size > 480) { y = 480 - size; }
		}
		
		public function get t (): Number { return y - size; }
		public function get top (): Number { return y - size; }
		
		public function get b (): Number { return y + size; }
		public function get bottom (): Number { return y + size; }
	}
}
