package net.vis4.data 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * The DataView class maps a set of points in a given boundary rectangle to a desired output 
	 * rectangle (eg the size of the flash stage) while preserving the original aspect ratio. 
	 * You can pass in an optional third parameter to determine the horizontal alignment 
	 * (the defaults is center).
	 * 
	 * @author gka
	 */
	public class DataView 
	{
		private var _xOffset:Number;
		private var _yOffset:Number;
		private var _scale:Number;
		private var _halign:String;
		private var _screen:Rectangle;
		
		/**
		 * creates a new DataView instance
		 * 
		 * @param	dataBounds bounding box of all points that are to display inside the screenBounds
		 * @param	screenBounds desired output size, eg the stage
		 * @param	hAlign horizontal align, defaults to center
		 */
		public function DataView(dataBounds:Rectangle, screenBounds:Rectangle, hAlign:String = 'center') 
		{
			//trace(dataBounds, screenBounds, hAlign);
			var dataRatio:Number = dataBounds.width / dataBounds.height;
			var screenRatio:Number = screenBounds.width / screenBounds.height;
			_screen = screenBounds;
			
			_halign = hAlign;
			var scale:Number;
			if (dataRatio > screenRatio) {
				_scale = screenBounds.width / dataBounds.width;			
				_xOffset = -dataBounds.left  + screenBounds.left * _scale;				
				_yOffset = (screenBounds.height / _scale - dataBounds.height) / 2  - dataBounds.top  + screenBounds.top * _scale;	;
			} else {
				_scale = screenBounds.height / dataBounds.height;
				_yOffset = -dataBounds.top + screenBounds.top * _scale;	
				_xOffset = -dataBounds.left  + screenBounds.left * _scale;
				if (_halign == 'center') _xOffset += (screenBounds.width / _scale - dataBounds.width) / 2;
				else if (_halign == 'right') _xOffset += (screenBounds.width / _scale - dataBounds.width);
			}
			//trace(scale, _xOffset, _yOffset);
		}
		
		public function get xOffset():Number { return _xOffset; }
		
		public function get yOffset():Number { return _yOffset; }
		
		/**
		 * scale factor
		 */
		public function get scale():Number { return _scale; }
		
		/**
		 * screen bounds
		 */		
		public function get screen():Rectangle { return _screen; }
		
		/**
		 * reverse screen bounds
		 */
		public function get rscreen():Rectangle { return rr(_screen); }
		
		/**
		 * projects a point from dataBounds to screenBounds
		 * 
		 * @param	point the point to be converted
		 * @return the projected point
		 */
		public function cp(point:Point):Point
		{
			return new Point(cx(point.x), cy(point.y));
		}
		
		/**
		 * inverse projection of cp()
		 * 
		 * @param	point
		 * @return
		 */
		public function rp(point:Point):Point
		{
			return new Point(rx(point.x), ry(point.y));
		}		
		
		/**
		 * projects an x value from dataBounds to screenBounds
		 * 
		 * @param	x
		 * @return
		 */
		public function cx(x:Number):Number
		{
			return (xOffset + x) * scale;
		}
		
		/**
		 * projects an y value from dataBounds to screenBounds
		 * 
		 * @param	y
		 * @return
		 */
		public function cy(y:Number):Number
		{
			return (yOffset + y) * scale;
		}
	
		/**
		 * inverse projection of cx()
		 * 
		 * @param	x
		 * @return
		 */
		public function rx(x:Number):Number
		{
			return (x / scale) - xOffset;
		}
		
		/**
		 * inverse projection of cy()
		 * 
		 * @param	y
		 * @return
		 */
		public function ry(y:Number):Number
		{
			return (y / scale) - yOffset;
		}
		
		/**
		 * checks if two different views have the same parameters
		 * 
		 * @param	dv
		 * @return
		 */
		public function equals(dv:DataView):Boolean
		{
			return dv.scale == scale && dv.xOffset == xOffset && dv.yOffset == yOffset;
		}
		
		/**
		 * projects an rectangle from dataBounds to screenBounds
		 * 
		 * @param	r
		 * @return
		 */
		public function cr(r:Rectangle):Rectangle
		{
			return new Rectangle(cx(r.left), cy(r.top), r.width * scale, r.height * scale); 
		}
		
		/**
		 * inverse projection of cr()
		 * 
		 * @param	r
		 * @return
		 */
		public function rr(r:Rectangle):Rectangle
		{
			return new Rectangle(rx(r.left), ry(r.top), r.width / scale, r.height / scale);
		}
		
		/**
		 * use this function to check wether an object is visible in the current
		 * view or not.
		 * 
		 * @param	box
		 * @return
		 */
		public function intersectsRect(box:Rectangle):Boolean
		{
			return _screen.intersects(cr(box));
		}
		
		
		/**
		 * use this function to check wether a point lays inside the current view or not.
		 * 
		 * @param	p
		 * @return
		 */
		public function containsPoint(p:Point):Boolean
		{
			return _screen.containsPoint(cp(p));
		}		
	}
	
}