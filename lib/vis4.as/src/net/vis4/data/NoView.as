package net.vis4.data 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.vis4.geom.IPolygon;
	import net.vis4.geom.Polygon;
	/**
	 * ...
	 * @author gka
	 */
	public class NoView extends DataView
	{
		
		public function NoView() 
		{
			super(new Rectangle(), new Rectangle());
		}
		
		override public function cp(point:Point):Point { return point; }
		
		override public function cpoly(polygon:IPolygon):Polygon { return polygon as Polygon; }
		
		override public function cr(r:Rectangle):Rectangle { return r; }
		
		override public function cx(x:Number):Number { return x; }
		
		override public function cy(y:Number):Number { return y; }
		
		override public function rp(point:Point):Point { return point; }
		
		//override public function rpoly(polygon:IPolygon):Polygon { return polygon as Polygon; }
		
		override public function rr(r:Rectangle):Rectangle { return r; }
		
		override public function rx(x:Number):Number { return x; }
		
		override public function ry(y:Number):Number { return y; }
		
	}

}