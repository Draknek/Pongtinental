package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class LineBall
	{
		public var canvas: Shape;
		
		public var xArray: Array;
		public var yArray: Array;
		
		private var maxLength: Number = 800;
		
		private var vx: Number;
		private var vy: Number;
		
		private var x1: Number;
		private var y1: Number;
		private var x2: Number;
		private var y2: Number;
		
		private var game: Game;
		
		private var contact: LineIntersection;
		
		public var colour: uint = 0xFF0000;
		
		public function LineBall (_game: Game)
		{
			game = _game;
			
			canvas = new Shape();
			
			spawn();
		}
		
		private function spawn (): void
		{
			x2 = 320;
			y2 = 160;
			
			vx = Math.random() * 3 + 2;
			vx *= (Math.random() < 0.5) ? -1 : 1;
			
			vy = Math.random() * 6 - 3;
			
			xArray = new Array();
			yArray = new Array();
			
			xArray[0] = x2;
			yArray[0] = y2;
			xArray[1] = x2;
			yArray[1] = y2;
		}
		
		private function test (ax: Number, ay: Number, bx: Number, by: Number, r: Number = 2): Boolean
		{
			contact = new LineIntersection();
			
			var movement: Line = new Line(x1, y1, x2, y2);
			var barrier: Line = new Line(ax, ay, bx, by);
			
			var hit: Boolean = false;
			
			if (r > 0)
			{
				hit = Line.intersectsR(movement, barrier, r, contact);
			}
			else
			{
				hit = Line.intersects(movement, barrier, contact);
			}
			
			if (hit)
			{
				x2 = contact.x;
				y2 = contact.y;
				
				xArray.push(contact.x);
				yArray.push(contact.y);
				
				var nx: Number = by - ay;
				var ny: Number = ax - bx;
				
				var nz: Number = Math.sqrt(nx*nx + ny*ny);
				
				nx /= nz;
				ny /= nz;
				
				var speed: Number = vx*nx + vy*ny;
				
				vx -= 2 * nx * speed;
				vy -= 2 * ny * speed;
				
				x2 += (1 - contact.t) * vx;
				y2 += (1 - contact.t) * vy;
				
				return true;
			}
			
			return false;
		}
		
		public function update (): void
		{
			xArray.pop();
			yArray.pop();
			
			x1 = x2;
			y1 = y2;
			
			x2 = x1 + vx;
			y2 = y1 + vy;
			
			var p1: Paddle = game.player1;
			var p2: Paddle = game.player2;
			
			if (test(p1.x, p1.top, p1.x, p1.bottom))
			{
				var diff: Number = contact.y - p1.y;
				
				vy += diff * 0.1;
				vy -= p1.vy * 0.1;
			}
			
			if(test(p2.x, p2.top, p2.x, p2.bottom))
			{
				diff = contact.y - p2.y;
				
				vy += diff * 0.1;
				vy -= p2.vy * 0.1;
			}
			
			test(0, 0, 0, 480); // left
			test(640, 480, 640, 0); // right
			
			test(0, 480, 640, 480); // bottom
			test(640, 0, 0, 0); // top
			
			//x2 = x2 - 0.01 * vx;
			//y2 = y2 - 0.01 * vy;
			
			xArray.push(x2);
			yArray.push(y2);
			
			var length: Number = 0;
			
			for (var i: uint = 0; i < xArray.length - 1; i++)
			{
				var dx: Number = xArray[i] - xArray[i+1];
				var dy: Number = yArray[i] - yArray[i+1];
				
				length += Math.sqrt(dx*dx + dy*dy);
			}
			
			var excess: Number = length - maxLength;
			
			// shorten tail
			while (excess > 0)
			{
				dx = xArray[1] - xArray[0];
				dy = yArray[1] - yArray[0];
				
				var dz: Number = Math.sqrt(dx*dx + dy*dy);
				
				if (dz > excess)
				{
					dx /= dz;
					dy /= dz;
					
					xArray[0] += dx * excess;
					yArray[0] += dy * excess;
					
					break;
				}
				else
				{
					excess -= dz;
					
					xArray.shift();
					yArray.shift();
				}
			}
			
			// draw
			canvas.graphics.clear();
			
			canvas.graphics.lineStyle(1, colour);
			canvas.graphics.moveTo(xArray[0], yArray[0]);
			
			for (i = 1; i < xArray.length; i++)
			{
				canvas.graphics.lineTo(xArray[i], yArray[i]);
			}
		}
	}
}
