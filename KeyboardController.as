package
{
	public class KeyboardController extends Controller
	{
		private var upKey: uint;
		private var downKey: uint;
		
		public function KeyboardController (_up: uint, _down: uint)
		{
			upKey = _up;
			downKey = _down;
		}
		
		public override function getDirection (): int
		{
			var dir: int = 0;
			
			if (Input.keyPressed(upKey))   { dir -= 1; }
			if (Input.keyPressed(downKey)) { dir += 1; }
			
			return dir;
		}
	}
}


