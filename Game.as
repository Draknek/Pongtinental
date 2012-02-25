package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	import com.coreyoneil.collision.CollisionList;
	
	public class Game extends Screen
	{
		public var player1: Player;
		public var player2: Player;
		
		public var score1: NumberTextField;
		public var score2: NumberTextField;
		
		public var ball: Ball;
		
		private var gameOver: Boolean = false;
		
		public var attractMode: Boolean = false;
		
		public var lines:Array = [];
		
		public var _collisionList:CollisionList;
		
		public function Game (_attractMode: Boolean = false)
		{
			attractMode = _attractMode;
			
			score1 = new NumberTextField(180, 0, "", "center", 100);
			score2 = new NumberTextField(460, 0, "", "center", 100);
			
			/*lineBall = new LineBall(this);
			addChild(lineBall.canvas);
			
			lines.push(lineBall);*/
			
			player1 = new Player(20, this);
			player2 = new Player(620, this);
			
			addChild(player1);
			addChild(player2);
			
			if (! attractMode)
			{
				addChild(score1);
				addChild(score2);
			}
			
			ball = new Ball(this);
			addChild(ball);
			addChild(ball.trail);
			
			_collisionList = new CollisionList(ball);
			
			_collisionList.addItem(player1);
			_collisionList.addItem(player2);
		}
		
		public override function update (): void
		{
			if (gameOver)
			{
				return;
			}
			
			player1.update();
			player2.update();
			
			for each (var line:LineBall in lines) {
				line.update();
			}
			
			for (var j:int = 0; j < 2; j++) {
				var collisions:Array = _collisionList.checkCollisions();
			
				for(var i:int = 0; i < collisions.length; i++)
				{
					var collision:Object = collisions[i];
			
					var angle:Number = collision.angle;
					var overlap:int = collision.overlapping.length;
					//var ball:Ball = collision.object2;
		
					var sin:Number = Math.sin(angle);
					var cos:Number = Math.cos(angle);
					
					/*var vx0:Number = ball.vx * cos + ball.vy * sin;
					var vy0:Number = ball.vy * cos - ball.vx * sin;
		
					//vx0 = .4;
				
					trace(overlap);
				
					vx0 *= 1.1;
				
					ball.vx = 0;//vx0 * cos - vy0 * sin;
					ball.vy = 0;//vy0 * cos + vx0 * sin;*/
				
					ball.vx -= cos * overlap / ball.radius;
					ball.vy -= sin * overlap / ball.radius;
				
					//ball.x += cos * overlap;
					//ball.y += sin * overlap;
				}
			
				ball.update(j);
			}
			
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
			
			gameOver = true;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, gameOverkeyDownListener, false, 0, true);
			
			var playButton: Button = new Button("Rematch", 54);
			
			playButton.x = 320 - playButton.width / 2;
			playButton.y = 300;
			
			playButton.addEventListener(MouseEvent.CLICK, function (param:*=null):void {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, gameOverkeyDownListener);
				Main.screen = new Game(false);
			});
			
			addChild(playButton);
			
			var play2Button: Button = new Button("Menu", 54);
			
			play2Button.x = 320 - playButton.width / 2;
			play2Button.y = 380;
			
			play2Button.addEventListener(MouseEvent.CLICK, function (param:*=null):void {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, gameOverkeyDownListener);
				Main.screen = MainMenu.instance;
			});
			
			addChild(play2Button);
		}
		
		private function gameOverkeyDownListener (ev: KeyboardEvent): void
		{
			if (ev.keyCode == 32) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, gameOverkeyDownListener);
			
				Main.screen = new Game;
			}
		}
	}
}
