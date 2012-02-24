package{

    import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class Circle extends Shape
	{
	    public function Circle(_x:Number,_y:Number,size:Number,alpha:Number)
	    {
	        graphics.beginFill(0xFFFFFF,alpha);
			graphics.drawCircle(0, 0, size);
			graphics.endFill();
			
			_x = x;
			_y = y;
	    }
	}
	
}
