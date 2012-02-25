package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class Trail extends Sprite
	{
	    private var delay_length:int;
	    public var trail_length:int;
	    private var size:int;
	    
	    private var delay_counter:int;
	    private var current_end_circle:int;
	    
	    
	    public var circles:Array;
	
	    public function Trail(x:Number,y:Number)
	    {
	     
	        delay_length = 6;
	        trail_length = 12;
	        size = 3;
	        
	        current_end_circle = 0;
	        
	        circles = new Array(trail_length);
	        circles[0] = new Circle(x,y,size,1);
	        addChild(circles[0]);
	        
	        delay_counter = delay_length;
	    }
	    
	    public function update(x:Number,y:Number) : void
	    {
	        delay_counter = delay_counter-1;
	        if(delay_counter<0)
	        {
	            var last_x:Number = circles[current_end_circle].x
	            var lasy_y:Number = circles[current_end_circle].y
	            move_trail(x,y);
	            if(current_end_circle<(trail_length-1))
	            {
	                current_end_circle = current_end_circle+1;
	                var alpha:Number = 0.5-current_end_circle/(2*trail_length);
	                
	                circles[current_end_circle] = new Circle(last_x,last_x,size,alpha);
	                addChild(circles[current_end_circle]);
	            }
	                
	        }
	    }
	    
	    public function move_trail(x:Number,y:Number): void
	    {
	        var i:int = current_end_circle
	        while(i>0)
	        {
	            circles[i].x = circles[i-1].x
	            circles[i].y = circles[i-1].y
	            i = i -1;
	        }
	        circles[0].x = x;
	        circles[0].y = y;
	    }
	}
	
}
