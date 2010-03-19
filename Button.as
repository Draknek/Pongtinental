package
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.MouseEvent;
	
	public class Button extends Sprite
	{
		public var textField: MyTextField;
		
		public function Button (_text: String, _textSize: Number = 16, _width: Number = 0, _colour: int = 0x000000)
		{
			textField = new MyTextField(10, 5, _text, "left", _textSize);
			
			var _height: Number = textField.height + 10;
			
			_width = Math.max(_width, textField.width + 20);
			
			textField.x = _width / 2 - textField.width / 2;
			
			addChild(textField);
			
			/*graphics.beginFill(_colour);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			
			graphics.lineStyle(4, 0x000000);
			graphics.drawRect(0, 0, _width, _height);*/
			
			buttonMode = true;
			mouseChildren = false;
			
			addEventListener(MouseEvent.ROLL_OVER, function (param: * = 0) : void {textField.textColor = 0x00FF00});
			addEventListener(MouseEvent.ROLL_OUT, function (param: * = 0) : void {textField.textColor = 0xFFFFFF});
		}
		
	}
}

