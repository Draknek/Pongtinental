package
{
	import flash.ui.Keyboard;
	
	public class Settings
	{
		public static var player1Controller: String = "AI";
		public static var player2Controller: String = "Keyboard";
		
		public static var player1Up: uint = Key.W;
		public static var player1Down: uint = Key.S;
		public static var player1Left: uint = Key.A;
		public static var player1Right: uint = Key.D;
		
		public static var player2Up: uint = Keyboard.UP;
		public static var player2Down: uint = Keyboard.DOWN;
		public static var player2Left: uint = Keyboard.LEFT;
		public static var player2Right: uint = Keyboard.RIGHT;
		
		public static var linesHitEachOther: Boolean = true;
		
		public static var targetScore: uint = 6;
	}
}


