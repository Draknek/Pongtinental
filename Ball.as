package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class Ball extends Shape
	{
		public var vx: Number;
		public var vy: Number;
		
		private var x1: Number;
		private var y1: Number;
		private var x2: Number;
		private var y2: Number;
		
		private var game: Game;
		
		private var contact: LineIntersection;
		
		private var respawn: Boolean = false;
		
		public var trail: Trail;
		
		public var radius:Number = 4;
		
		public function Ball (_game: Game)
		{
			game = _game;
			
			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
			
			spawn();
			
			trail = new Trail(x,y);
		}
		
		private function spawn (): void
		{
			respawn = false;
			
			x = 320;
			y = 240;
			
			vx = Math.random() * 2 + 3;
			vx *= (Math.random() < 0.5) ? -1 : 1;
			
			vy = Math.random() * 6 - 3;
		}
		
		private function test (ax: Number, ay: Number, bx: Number, by: Number, r: Number = 6): Boolean
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
				
				var nx: Number = by - ay;
				var ny: Number = ax - bx;
				
				var nz: Number = Math.sqrt(nx*nx + ny*ny);
				
				nx /= nz;
				ny /= nz;
				
				var speed: Number = vx*nx + vy*ny;
				
				//trace("Old speed: " + vx + ", " + vy);
				
				vx -= 2 * nx * speed;
				vy -= 2 * ny * speed;
				
				//trace("New speed: " + vx + ", " + vy);
				
				x2 += (1 - contact.t) * vx;
				y2 += (1 - contact.t) * vy;
				
				return true;
			}
			
			return false;
		}
		
		public function update (): void
		{
			if (respawn)
			{
				spawn();
			}
			
			x1 = x;
			y1 = y;
			
			x2 = x + vx;
			y2 = y + vy;
			
			var p1: Player = game.player1;
			var p2: Player = game.player2;
			
			/*if (test(p1.x, p1.top, p1.x, p1.bottom, radius + 2))
			{
				var diff: Number = contact.y - p1.y;
				
				vy += diff * 0.1;
				vy -= p1.vy * 0.1;
				
				vx += 0.25;
			}
			
			if(test(p2.x, p2.top, p2.x, p2.bottom, radius + 2))
			{
				diff = contact.y - p2.y;
				
				vy += diff * 0.1;
				vy -= p2.vy * 0.1;
				
				vx -= 0.25;
			}*/
			
			if (test(0, 0, 0, 480, radius)) // left
			{
				game.score2.value += 1;
				
				if (vx > 3)
				{
					vx -= 0.25;
				}
				
				respawn = true;
			}
			
			if(test(640, 480, 640, 0, radius)) // right
			{
				game.score1.value += 1;
				
				if (vx < -3)
				{
					vx += 0.25;
				}
				
				respawn = true;
			}
			
			test(0, 480, 640, 480, radius); // bottom
			test(640, 0, 0, 0, radius); // top
			
			for each (var lineBall:LineBall in game.lines) {
				var xArr: Array = lineBall.xArray;
				var yArr: Array = lineBall.yArray;
			
				for (var i: uint = 0; i < xArr.length - 1; i++)
				{
					test(xArr[i], yArr[i], xArr[i+1], yArr[i+1]);
				}
			}
			
			x = x2;// - 0.01 * vx;
			y = y2;// - 0.01 * vy;
			
			trail.update(x,y);
		}
	}
}
