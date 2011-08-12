package net.vis4.geom 
{
	import flash.display.Graphics;
	import flash.geom.Point;
	/**
	 * ...
	 * 
	 * based on
	 * http://flashcove.net/795/cubic-spline-generation-in-as3-catmull-rom-curves/
	 *
	 * @author Gregor Aisch
	 */
	public class CatmullRomSpline 
	{
		
		public static var segments:int = 20;
		
		public static function draw(g:Graphics, points:Array, closed:Boolean = true, moveToFirst:Boolean = true):void
		{
			var p:Point, splinePoints:Array = getSplinePoints(points, closed);
			
			for (var i:int = 0; i < splinePoints.length; i++) {
				p = Point(splinePoints[i]);
				if (moveToFirst && i == 0) g.moveTo(p.x, p.y);
				else g.lineTo(p.x, p.y);
			}
			
			
		}
		
		protected static function getSplinePoints(points:Array, closed:Boolean):Array 
		{
			var p0:Point, p1:Point, p2:Point, p3:Point, 
				n:int = points.length,
				maxk:int = n - 1,
				incr:Number = 1 / Math.max(1, segments),
				setX:Array, setY:Array,
				spoints:Array = [];
			
			for(var k:int = 0; k < (closed ? n : n-1); k++) { 
				p0 = points[k];
				p1 = points[!closed ? Math.min(k + 1, maxk) : (k + 1) % n];
				p2 = points[!closed ? Math.min(k + 2, maxk) : (k + 2) % n];
				p3 = points[!closed ? Math.min(k + 3, maxk) : (k + 3) % n];
				
				for (var g:Number = 0.0; g < 1.0; g += incr) { 
					
					
					setX = calculateCatmull(g, p0.x, p1.x, p2.x, p3.x);
					setY = calculateCatmull(g, p0.y, p1.y, p2.y, p3.y);
					
					spoints.push(new Point(setX[0], setY[0]));
					
				}
			}
			return spoints;
		}
		

		protected static function calculateCatmull(t:Number, p0:Number, p1:Number, p2:Number, p3:Number):Array
		{
			var t2:Number = t * t,
				t3:Number = t2 * t,
				n1:Number = (0.5 * ( (2 * p1) + ( -p0 + p2) * t +(2 * p0 - 5 * p1 + 4 * p2 - p3) * t2 +( -p0 + 3 * p1 - 3 * p2 + p3) * t3)),
				n2:Number = 0.5 * ( -p0 + p2) + t * (2 * p0 - 5 * p1 + 4 * p2 - p3) + t2 * 1.5 * ( -p0 + 3 * p1 - 3 * p2 + p3),
				n3:Number = (2 * p0 - 5 * p1 + 4 * p2 - p3) + t * 3.0 * ( -p0 + 3 * p1 - 3 * p2 + p3);
			return [n1, n2, n3];
		}
		
		
	}

}