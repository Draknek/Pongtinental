package
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import com.lorentz.processing.*;
	import com.lorentz.SVG.display.*;
	import com.lorentz.SVG.events.*;
	
	import com.greensock.*;
	
	public class MainMenu extends Screen
	{
		private var demoGame: Game;
		
		namespace svg = "http://www.w3.org/2000/svg";
		
		[Embed(source="images/continents.svg", mimeType="application/octet-stream")]
		public static const CONTINENTS:Class;
		
		public var loading:MyTextField;
		
		public var earth:Sprite;
		
		public static var instance:MainMenu;
		
		public function MainMenu ()
		{
			instance = this;
			
			demoGame = new Game(true);
			
			demoGame.alpha = 0.5;
			
			addChild(demoGame);
			
			addChild(new MyTextField(320, 20, "Pongtinental", "center", 99));
			
			//addChild(new MyTextField(320, 300, "Press any key to begin", "center", 27));
			
			initContinents();
		}
		
		public function addButtons ():void
		{
			var playButton: Button = new Button("Single player", 54);
			
			playButton.x = 320 - playButton.width / 2;
			playButton.y = 200;
			
			playButton.addEventListener(MouseEvent.CLICK, function (param:*=null):void {
				Settings.player1Controller = "AI";
				Main.screen = new Game(false);
			});
			
			addChild(playButton);
			
			var play2Button: Button = new Button("Multiplayer", 54);
			
			play2Button.x = 320 - playButton.width / 2;
			play2Button.y = 300;
			
			play2Button.addEventListener(MouseEvent.CLICK, function (param:*=null):void {
				Settings.player1Controller = "Keyboard";
				Main.screen = new Game(false);
			});
			
			addChild(play2Button);
			
			var settingsButton: Button = new Button("Settings", 54);
			
			settingsButton.x = 320 - settingsButton.width / 2;
			settingsButton.y = 275;
			
			settingsButton.addEventListener(MouseEvent.CLICK, function (param:*=null):void {Main.screen = new SettingsMenu();});
			
			//addChild(settingsButton);
			
		}
		
		public function initContinents (): void
		{
			if (Main.continents) return;
			
			Main.continents = {};
			Main.continentNames = [];
			
			ProcessExecutor.instance.initialize(Main.instance.stage);
			
			earth = new Sprite;
			
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
				if (Main.continents[continent.@id] || id) {
					continent.@style += "; display:none;";
				} else {
					id = continent.@id;
					Main.continentNames.push(id);
					Main.continents[id] = bitmap = new BitmapData(640, 480, true, 0x0);
				}
			}
			
			if (! id) {
				// Done loading!
				
				loading.parent.removeChild(loading);
				
				TweenLite.to(earth, 1.0, {alpha: 0.5});
				
				addButtons();
				
				return;
			}
			
			function complete ():void
			{
				bitmap.draw(svg);
				
				var image:Bitmap = new Bitmap(bitmap);
				
				earth.addChild(image);
				earth.removeChild(svg);
				
				demoGame._collisionList.addItem(image);
				
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
