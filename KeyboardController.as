package
{
	public class KeyboardController extends Controller
	{
		private var upKey: uint;
		private var downKey: uint;
		private var leftKey: uint;
		private var rightKey: uint;
		
		public function KeyboardController (_up: uint, _down: uint, _left:uint, _right:uint)
		{
			upKey = _up;
			downKey = _down;
			leftKey = _left;
			rightKey = _right;
		}
		
		public override function getDirection (): int
		{
			var dir: int = 0;
			
			if (Input.keyPressed(upKey))   { dir -= 1; }
			if (Input.keyPressed(downKey)) { dir += 1; }
			
			return dir;
		}
		
		public override function getX (): int
		{
			var dir: int = 0;
			
			if (Input.keyPressed(leftKey))   { dir -= 1; }
			if (Input.keyPressed(rightKey)) { dir += 1; }
			
			return dir;
		}
		
		public override function getY (): int
		{
			var dir: int = 0;
			
			if (Input.keyPressed(upKey))   { dir -= 1; }
			if (Input.keyPressed(downKey)) { dir += 1; }
			
			return dir;
		}
	}
}


