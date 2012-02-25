package
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import com.lorentz.processing.*;
	import com.lorentz.SVG.display.*;
	import com.lorentz.SVG.events.*;
	
	public class MainMenu extends Screen
	{
		private var demoGame: Game;
		
		namespace svg = "http://www.w3.org/2000/svg";
		
		[Embed(source="images/continents.svg", mimeType="application/octet-stream")]
		public static const CONTINENTS:Class;
		
		public static var continents:Object;
		
		public var loading:MyTextField;
		
		public function MainMenu ()
		{
			demoGame = new Game(true);
			
			demoGame.alpha = 0.5;
			
			addChild(demoGame);
			
			addChild(new MyTextField(320, 20, "Pongtinental", "center", 99));
			
			//addChild(new MyTextField(320, 300, "Press any key to begin", "center", 27));
			
			var playButton: Button = new Button("Play", 54);
			
			playButton.x = 320 - playButton.width / 2;
			playButton.y = 200;
			
			playButton.addEventListener(MouseEvent.CLICK, function (param:*=null):void {Main.screen = new Game(false);});
			
			//addChild(playButton);
			
			var settingsButton: Button = new Button("Settings", 54);
			
			settingsButton.x = 320 - settingsButton.width / 2;
			settingsButton.y = 275;
			
			settingsButton.addEventListener(MouseEvent.CLICK, function (param:*=null):void {Main.screen = new SettingsMenu();});
			
			//addChild(settingsButton);
			
			initContinents();
		}
		
		public function initContinents (): void
		{
			if (continents) return;
			
			continents = {};
			
			ProcessExecutor.instance.initialize(Main.instance.stage);
			
			var earth:Sprite = new Sprite;
			
			earth.y = 200;
			
			addChild(earth);
			
			addChild(loading = new MyTextField(320, 420, "Loading...", "center", 36));
			
			initNextContinent(earth);
		}
		
		public function initNextContinent (earth:Sprite): void
		{
			use namespace svg;
			var xml:XML = getXML(CONTINENTS);
			
			var id:String;
			var bitmap:BitmapData;
			
			for each (var continent:XML in xml.g) {
				if (continents[continent.@id] || id) {
					continent.@style += "; display:none;";
				} else {
					id = continent.@id;
					continents[id] = bitmap = new BitmapData(640, 480, true, 0x0);
				}
			}
			
			if (! id) {
				// Done loading!
				
				loading.parent.removeChild(loading);
				
				earth.alpha = 0.5;
				
				return;
			}
			
			function complete ():void
			{
				bitmap.draw(svg);
				earth.addChild(new Bitmap(bitmap));
				earth.removeChild(svg);
				
				initNextContinent(earth);
			}
			
			var svg:SVGDocument = new SVGDocument();
			svg.parse(xml);
			earth.addChild(svg);
			
			svg.addEventListener(SVGEvent.RENDERED, complete);
		}
		
		/**
		 * Loads the file as an XML object.
		 * @param	file		The embedded file to load.
		 * @return	An XML object representing the file.
		 */
		public static function getXML(file:Class):XML
		{
			var bytes:ByteArray = new file;
			return XML(bytes.readUTFBytes(bytes.length));
		}
		
		public override function init (): void
		{
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, startGamekeyDownListener, false, 0, true);
		}
		
		public override function update (): void
		{
			demoGame.update();
		}
		
		private function startGamekeyDownListener (ev: KeyboardEvent): void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, startGamekeyDownListener);
			
			Main.screen = new SettingsMenu();//Game(false);
		}
	}
}
