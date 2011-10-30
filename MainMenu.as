package
{
	import flash.display.*;
	import flash.events.*;
	
	public class MainMenu extends Screen
	{
		private var demoGame: Game;
		
		public function MainMenu ()
		{
			demoGame = new Game(true);
			
			demoGame.alpha = 0.5;
			
			addChild(demoGame);
			
			addChild(new MyTextField(320, 20, "Trong", "center", 150));
			
			//addChild(new MyTextField(320, 300, "Press any key to begin", "center", 25));
			
			var playButton: Button = new Button("Play", 50);
			
			playButton.x = 320 - playButton.width / 2;
			playButton.y = 200;
			
			playButton.addEventListener(MouseEvent.CLICK, function (param:*=null):void {Main.screen = new Game(false);});
			
			addChild(playButton);
			
			var settingsButton: Button = new Button("Settings", 50);
			
			settingsButton.x = 320 - settingsButton.width / 2;
			settingsButton.y = 275;
			
			settingsButton.addEventListener(MouseEvent.CLICK, function (param:*=null):void {Main.screen = new SettingsMenu();});
			
			addChild(settingsButton);
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
