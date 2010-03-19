
package
{
	import flash.display.*;

	public class Preloader extends Screen
	{
		public static function init (startup: Function): void
		{
			if (Main.instance.loaderInfo.bytesLoaded < Main.instance.loaderInfo.bytesTotal)
			{
				Main.screen = new Preloader(startup);
			}
			else
			{
				startup();
			}
		}
		
		private var startup: Function;
		private var progressBar: Shape;
		
		public function Preloader (_startup: Function)
		{
			startup = _startup;
			
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, 640, 480);
			graphics.endFill();
			
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(68, 228, 504, 24);
			graphics.endFill();
			
			progressBar = new Shape();
			
			addChild(progressBar);
		}

		public override function update (): void
		{
			var p:Number = (this.loaderInfo.bytesLoaded / this.loaderInfo.bytesTotal);
			
			progressBar.graphics.beginFill(0x000000);
			progressBar.graphics.drawRect(70, 230, p * 500, 20);
			progressBar.graphics.endFill();
			
			if (this.loaderInfo.bytesLoaded >= this.loaderInfo.bytesTotal)
			{
				startup();
			}
		}
	}
}


