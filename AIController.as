package
{
	public class AIController extends Controller
	{
		private var paddle: Paddle;
		private var game: Game;
		
		private var targetY: Number = 240;
		
		public function AIController (_paddle: Paddle, _game: Game)
		{
			paddle = _paddle;
			game = _game;
		}
		
		private function findTarget (): void
		{
			var t: Number = (game.ball.x - paddle.x) / -game.ball.vx;
			
			if (t > 65 || t < 0) { return; }
			
			targetY += (game.ball.y + game.ball.vy * t - targetY) * (1 - t * 0.005) * 0.5;
		}
		
		public override function getDirection (): int
		{
			findTarget();
			
			var diff: Number = targetY - paddle.y;
			
			if (diff > paddle.size / 2)
			{
				return 1;
			}
			else if (diff < -paddle.size / 2)
			{
				return -1;
			}
			
			return 0;
		}
	}
}


