package
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	public class Player extends Sprite
	{
		public var size: Number = 30;
		public var speed: Number = 5;
		
		public var vy: Number;
		
		private var game: Game;
		
		private var controller: Controller;
		
		public function Player (_x: Number, _game: Game)
		{
			game = _game;
			
			if (game.attractMode) {
				graphics.lineStyle(4, 0x00FF00);
				graphics.moveTo(0, -size);
				graphics.lineTo(0, size);
			} else {
				var i:int = Math.random() * Main.continentNames.length;
				var continent:String = Main.continentNames[i];
				
				var bitmap:BitmapData = Main.continents[continent];
				
				var image:Bitmap = new Bitmap(bitmap);
				
				var bounds:Rectangle = bitmap.getColorBoundsRect(0xFFFFFFFF, 0x000000, false);
				
				var side:int = (_x < 320) ? -1 : 1;
				
				image.x = -bounds.x - bounds.width * 0.5;
				image.y = -bounds.y - bounds.height * 0.5;
				
				_x -= side * bounds.width * 0.5;
				
				addChild(image);
			}
			
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
