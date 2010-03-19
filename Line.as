package
{
	public class Line
	{
		public var x1: Number;
		public var y1: Number;
		public var x2: Number;
		public var y2: Number;
		
		public function Line (_x1: Number, _y1: Number, _x2: Number, _y2: Number)
		{
			x1 = _x1;
			y1 = _y1;
			x2 = _x2;
			y2 = _y2;
		}
		
		public static function intersects (ab: Line, cd: Line, info: LineIntersection): Boolean
		{
			// Sign of areas correspond to which side of ab points c and d are
			var a1: Number = Signed2DTriArea(ab.x1, ab.y1, ab.x2, ab.y2, cd.x2, cd.y2); // Compute winding of abd (+ or -)
			var a2: Number = Signed2DTriArea(ab.x1, ab.y1, ab.x2, ab.y2, cd.x1, cd.y1); // To intersect, must have sign opposite of a1

			// If c and d are on different sides of ab, areas have different signs
			if (a1 != 0.0 && a2 != 0.0 && a1*a2 < 0.0) {
				// Compute signs for a and b with respect to segment cd
				var a3: Number = Signed2DTriArea(cd.x1, cd.y1, cd.x2, cd.y2, ab.x1, ab.y1); // Compute winding of cda (+ or -)
				// Since area is constant a1-a2 = a3-a4, or a4=a3+a2-a1
				//      float a4 = Signed2DTriArea(c, d, b); // Must have opposite sign of a3
				var a4: Number = a3 + a2 - a1;
				// Points a and b on different sides of cd if areas have different signs
				if (a3 * a4 < 0.0) {
					// Segments intersect. Find intersection point along L(t)=a+t*(b-a).
					// Given height h1 of a over cd and height h2 of b over cd,
					// t = h1 / (h1 - h2) = (b*h1/2) / (b*h1/2 - b*h2/2) = a3 / (a3 - a4),
					// where b (the base of the triangles cda and cdb, i.e., the length
					// of cd) cancels out.
					if (info)
					{
						info.t = a3 / (a3 - a4);
						info.x = ab.x1 + info.t * (ab.x2 - ab.x1);
						info.y = ab.y1 + info.t * (ab.y2 - ab.y1);
					}
					
					return true;
				}
			}

			// Segments not intersecting (or collinear)
			return false;
		}

		public static function intersectsR (ray: Line, line: Line, r: Number, contact: LineIntersection): Boolean
		{
			// normal to line
			var nx: Number = line.y2 - line.y1;
			var ny: Number = line.x1 - line.x2;
			
			var nz: Number = Math.sqrt(nx*nx + ny*ny);
			
			nx /= nz;
			ny /= nz;
			
			// ray ab
			var dx: Number = ray.x2 - ray.x1;
			var dy: Number = ray.y2 - ray.y1;
			
			var n_dot_ab: Number = dx*nx + dy*ny;
			
			if (n_dot_ab > 0)
			{
				n_dot_ab *= -1;
				nx *= -1;
				ny *= -1;
			}
			
			var n_dot_line: Number = nx * line.x1 + ny * line.y1; // distance of line from origin
			var n_dot_a: Number = nx * ray.x1 + ny * ray.y1; // distance of a from origin
			
			if (n_dot_a < n_dot_line)
			{
				// ray going away from line: no intersection
				return false;
			}
			
			var t: Number = (n_dot_line - n_dot_a + r) / n_dot_ab;
			
			if (t > 1)
			{
				// ray does not reach line this frame: no intersection
				return false;
			}
			
			if (t < 0)
			{
				t = 0;
			}
			
			// find contact point
			contact.x = ray.x1 + t * dx;
			contact.y = ray.y1 + t * dy;
			
			contact.t = t;
			
			// WARNING: from this point on, ab is the line and NOT the ray as in previous section
			
			var abx: Number = line.x2 - line.x1;
			var aby: Number = line.y2 - line.y1;
			
			var acx: Number = contact.x - line.x1;
			var acy: Number = contact.y - line.y1;
			
			var e: Number = acx * abx + acy * aby;
			
			if (e < 0)
			{
				// a is closest point to contact: should check end collision
				return false;
			}
			
			var f: Number = abx * abx + aby * aby;
			
			if (e > f)
			{
				// b is closest point to contact: should check end collision
				return false;
			}
			
			return true;
		}

		// Returns 2 times the signed triangle area. The result is positive if
		// abc is ccw, negative if abc is cw, zero if abc is degenerate.
		private static function Signed2DTriArea(ax: Number, ay: Number, bx: Number, by: Number, cx: Number, cy: Number): Number
		{
		return (ax - cx) * (by - cy) - (ay - cy) * (bx - cx);
		}

	}
	
}
