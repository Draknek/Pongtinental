package
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import com.greensock.*;
	
	public class Player extends Sprite
	{
		public var size: Number = 30;
		public var speed: Number = 5;
		
		public var vy: Number;
		
		private var game: Game;
		
		private var controller: Controller;
		
		public var image:Bitmap;
		
		public var livesContainer:Sprite;
		public var lives:Object = {};
		
		public var continent:String;
		
		public function Player (_x: Number, _game: Game)
		{
			game = _game;
			
			var side:int = (_x < 320) ? -1 : 1;
			
			x = _x;
			y = 240;
			
			if (game.attractMode) {
				graphics.lineStyle(4, 0x00FF00);
				graphics.moveTo(0, -size);
				graphics.lineTo(0, size);
			} else {
				livesContainer = new Sprite;
			
				livesContainer.x = (x < 320) ? 0 : 640 - Main.continentsSmall[Main.continentNames[0]].width;
				livesContainer.y = 10;
			
				livesContainer.alpha = 0.5;
			
				game.addChild(livesContainer);
			
				for each (var id:String in Main.continentNames) {
					lives[id] = new Bitmap(Main.continentsSmall[id]);
					livesContainer.addChild(lives[id]);
				}
				
				newContinent();
			}
			
			controller = Controller.create(this, game);
			
		}
		
		public function newContinent ():void
		{
			if (game.attractMode) return;
			
			if (image) {
				removeChild(image);
				TweenLite.to(lives[continent], 0.5, {alpha: 0});
				lives[continent] = null;
			}
			
			var side:int = (x < 320) ? -1 : 1;

			do {
				var i:int = Math.random() * Main.continentNames.length;
				continent = Main.continentNames[i];
			}
			while (! lives[continent]);
			
			var bitmap:BitmapData = Main.continents[continent];
			
			image = new Bitmap(bitmap);
			
			var bounds:Rectangle = bitmap.getColorBoundsRect(0xFFFFFFFF, 0x000000, false);
			
			image.x = -bounds.x - bounds.width * 0.5;
			image.y = -bounds.y - bounds.height * 0.5;
			
			x = 320 + side * 300;
			
			x -= side * bounds.width * 0.5;
			
			addChild(image);
			
			game.vol = 0.1;
			
			TweenLite.to(game, 1.0, {vol: 0.5, delay: 1.0});
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
