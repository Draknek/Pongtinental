package
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.MouseEvent;
	
	public class AdjustableNumberTextField extends Sprite
	{
		public var numberTextField: NumberTextField;
		
		public var min: int;
		public var max: int;
		
		public var callback: Function;
		
		private var up: Sprite;
		private var down: Sprite;
		
		public function AdjustableNumberTextField (_x: Number, _y: Number, _prefix: String, _autoSize: String = TextFieldAutoSize.CENTER, textSize: Number = 16, _callback: Function = null, _min: int = 0, _max: int = 99)
		{
			x = _x;
			y = _y;
			
			min = _min;
			max = _max;
			
			callback = _callback;
			
			numberTextField = new NumberTextField(0, 0, _prefix, "left", textSize);
			
			addChild(numberTextField);
			
			up = new Sprite();
			down = new Sprite();
			
			buttonify(up);
			buttonify(down);
			
			alignify();
		}
		
		private function buttonify (button: Sprite): void
		{
			button.buttonMode = true;
			button.mouseChildren = false;
			
			button.addEventListener(MouseEvent.ROLL_OVER, function (param: * = 0) : void {numberTextField.textColor = 0x00FF00});
			button.addEventListener(MouseEvent.ROLL_OUT, function (param: * = 0) : void {numberTextField.textColor = 0xFFFFFF});
			
			var valChange: int = (button == up) ? 1 : -1;
			
			button.addEventListener(MouseEvent.CLICK, function (param:*=null):void {value += valChange;});
			
			button.y = numberTextField.height * 0.5;
			
			button.graphics.beginFill(0x000000);
			button.graphics.drawRect(0, -0.5, 1, 1);
			button.graphics.endFill();
			
			button.graphics.lineStyle(0, 0xFFFFFF);
			button.graphics.moveTo(0.1, valChange*0.3);
			button.graphics.lineTo(0.5, -valChange*0.3);
			button.graphics.lineTo(0.9, valChange*0.3);
			
			button.scaleX = numberTextField.height * 0.5;
			button.scaleY = button.scaleX;
			
			addChild(button);
		}
		
		private function alignify (): void
		{
			var space: Number = 2;
			
			var totalWidth: Number = down.width + numberTextField.width + up.width + 2 * space;
			
			if (numberTextField.autoSize == "left")
			{
				down.x = 0;
			}
			else if (numberTextField.autoSize == "center")
			{
				down.x = -totalWidth * 0.5;
			}
			else if (numberTextField.autoSize == "right")
			{
				down.x = -totalWidth;
			}
			
			numberTextField.x = down.x + down.width + space;
			up.x = numberTextField.x + numberTextField.width + space;
		}
		
		public function set value(_value: int): void
		{
			numberTextField.value = _value;
			
			if (numberTextField.value < min)
			{
				numberTextField.value = min;
			}
			else if (numberTextField.value > max)
			{
				numberTextField.value = max;
			}
			
			alignify();
			
			if (callback != null)
			{
				callback(numberTextField.value);
			}
		}
		
		public function get value(): int
		{
			return numberTextField.value;
		}
		
	}
}

