package
{
	public class Controller
	{
		public function getDirection (): int
		{
			return 0;
		}
		
		public static function create (paddle: Paddle, game: Game): Controller
		{
			if (game.attractMode)
			{
				return new AIController(paddle, game);
			}
			
			if (paddle.x < 320)
			{
				return new AIController(paddle, game);
			}
			else
			{
				return new KeyboardController(Settings.player2Up, Settings.player2Down);
			}
		}
	}
}


