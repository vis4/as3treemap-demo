package net.vis4.data 
{
	
	/**
	 * ...
	 * @author gka
	 */
	public class DataRange 
	{
		protected var _min:Number;
		protected var _max:Number;
		
		public function DataRange() 
		{
			_max = Number.NEGATIVE_INFINITY;
			_min = Number.POSITIVE_INFINITY;
		}
		
		public function add(value:*):void
		{
			if (isNaN(Number(value))) throw new Error('DataRange: someone added a NaN-value');
			_min = Math.min(_min, Number(value));
			_max = Math.max(_max, Number(value));
		}
		
		public function get min():Number { return _min; }
		
		public function get max():Number { return _max; }
		
		public function get range():Number { return _max - _min; }
		
		public function ratio(v:Number):Number
		{
			return (v - _min) / range;
		}
		
		public function sqrtRatio(v:Number):Number
		{
			return Math.sqrt(ratio(v));
		}
		
		public function rootRatio(v:Number, rad:Number):Number
		{
			return Math.pow(ratio(v), 1/rad);
		}
		
		public function toString():String
		{
			return '(min=' + _min + ', max=' + _max + ')';
		}
	}
	
}