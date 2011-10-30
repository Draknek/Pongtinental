
package
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Screen extends Sprite
	{
		public function Screen ()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage (param: *): void
		{
			init();
		}
		
		public function init (): void {}
		public function update (): void {}
	}
}


