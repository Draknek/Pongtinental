package
{
	import flash.display.*;
	import flash.events.*;
	
	public class SettingsMenu extends Screen
	{
		public function SettingsMenu ()
		{
			//addChild(new MyTextField(320, 20, "Trong", "center", 150));
			
			addChild(new MyTextField(320, 20, "Settings", "center", 100));
			
			addChild(new MyTextField(300, 200, "Target score:", "right", 25));
			
			var targetScore: AdjustableNumberTextField = new AdjustableNumberTextField(340, 200, "", "left", 25, changeTargetScore, 1, 99)
			
			targetScore.value = Settings.targetScore;
			
			addChild(targetScore);
			
			addChild(new MyTextField(320, 250, "Press any key to return to menu", "center", 25));
			
			/*var button: Button = new Button("Play", 25);
			
			button.x = 320 - button.width / 2;
			button.y = 150;
			
			button.addEventListener(MouseEvent.CLICK, function (param:*=null):void {Main.screen = new Game(false);});
			
			addChild(button);*/
		}
		
		private function changeTargetScore (newTarget: int): void
		{
			Settings.targetScore = newTarget;
		}
		
		public override function init (): void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, startGamekeyDownListener, false, 0, true);
		}
		
		private function startGamekeyDownListener (ev: KeyboardEvent): void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, startGamekeyDownListener);
			
			Main.screen = new MainMenu();
		}
	}
}
