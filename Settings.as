package
{
	import flash.ui.Keyboard;
	
	public class Settings
	{
		public static var player1Controller: String = "AI";
		public static var player2Controller: String = "Keyboard";
		
		public static var player1Up: uint = 0;
		public static var player1Down: uint = 0;
		
		public static var player2Up: uint = Keyboard.UP;
		public static var player2Down: uint = Keyboard.DOWN;
		
		public static var linesHitEachOther: Boolean = true;
		
		public static var targetScore: uint = 5;
	}
}


