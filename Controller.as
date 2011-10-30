package
{
	public class Controller
	{
		public function getDirection (): int
		{
			return 0;
		}
		
		public function getX (): int
		{
			return 0;
		}
		
		public function getY (): int
		{
			return 0;
		}
		
		public static function create (paddle: Player, game: Game): Controller
		{
			if (game.attractMode)
			{
				return new AIController(paddle, game);
			}
			
			if (paddle.x < 320)
			{
				return new KeyboardController(Settings.player1Up, Settings.player1Down, Settings.player1Left, Settings.player1Right);
			}
			else
			{
				return new KeyboardController(Settings.player2Up, Settings.player2Down, Settings.player2Left, Settings.player2Right);
			}
		}
	}
}


