package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class Game extends Screen
	{
		public var player1: Paddle;
		public var player2: Paddle;
		
		public var score1: NumberTextField;
		public var score2: NumberTextField;
		
		public var ball: Ball;
		public var lineBall: LineBall;
		
		private var gameOver: Boolean = false;
		
		public var attractMode: Boolean = false;
		
		public function Game (_attractMode: Boolean = false)
		{
			attractMode = _attractMode;
			
			score1 = new NumberTextField(180, 0, "", "center", 100);
			score2 = new NumberTextField(460, 0, "", "center", 100);
			
			if (! attractMode)
			{
				addChild(score1);
				addChild(score2);
			}
			
			lineBall = new LineBall(this);
			addChild(lineBall.canvas);
			
			player1 = new Paddle(20, this);
			player2 = new Paddle(620, this);
			
			addChild(player1);
			addChild(player2);
			
			ball = new Ball(this);
			addChild(ball);
		}
		
		public override function update (): void
		{
			if (gameOver)
			{
				return;
			}
			
			player1.update();
			player2.update();
			
			lineBall.update();
			
			ball.update();
			
			if (attractMode)
			{
				return;
			}
			
			if (score1.value >= Settings.targetScore)
			{
				endGame("Left wins!");
			}
			
			if (score2.value >= Settings.targetScore)
			{
				endGame("Right wins!");
			}
		}
		
		private function endGame (message: String): void
		{
			addChild(new MyTextField(320, 180, message, "center", 50));
			addChild(new MyTextField(320, 260, "Press any key", "center", 25));
			
			gameOver = true;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, gameOverkeyDownListener, false, 0, true);
		}
		
		private function gameOverkeyDownListener (ev: KeyboardEvent): void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, gameOverkeyDownListener);
			
			Main.screen = new MainMenu();
		}
	}
}
