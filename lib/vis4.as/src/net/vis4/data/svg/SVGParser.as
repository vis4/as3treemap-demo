package net.vis4.data.svg 
{
	import com.adobe.utils.StringUtil;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import net.vis4.shapes.PointList;
	
	/**
	 * ...
	 * @author gka
	 */
	public class SVGParser 
	{
		
		public static function parse(svg:String):Object
		{
			var res:Object= {};
			res.shapes = new Dictionary(true);
			res.minX = Number.MAX_VALUE;
			res.maxX = Number.MIN_VALUE;
			res.minY = Number.MAX_VALUE;
			res.maxY = Number.MIN_VALUE;
			
			var i:uint = 0;
			do {
				var a:uint, b:uint, c:uint, d:uint, e:uint;
				var label:String, points:String, pointArr:PointList, p:Point;
				
				a = svg.indexOf('<polygon', i);
				b = svg.indexOf('<path', i);
				
				
				if (a > -1 && (a < b || b == -1)) {
					i = a;
					e = svg.indexOf('>', i);
					a = svg.indexOf('inkscape:label="', i);
					b = svg.indexOf('points="', i);
					if (a < e && b < e) {
						// found label and points
						label = svg.substring(a + 16, svg.indexOf('"', a + 16));
						points = svg.substring(b + 8, svg.indexOf('"', b + 8));
						pointArr = new PointList();
						
						var p2_arr:Array = points.split(' ');
						for each (var p1_str:String in p2_arr) {
							if (StringUtil.trim(p1_str) == '') continue;
							
							var p1_arr:Array = p1_str.split(',');
							if (p1_arr.length != 2) throw new Error(p1_str);
							p = new Point(Number(p1_arr[0]), Number(p1_arr[1]));
							if (p is Point) pointArr.push(p);
							else throw new Error(p + ' is not a Point');
							// calc min and max						
						}
						if (isNaN(pointArr.minX)) {
							trace('PointList.bounds: ' + pointArr.bounds);
						}
						res.minX = Math.min(res.minX, pointArr.minX);
						res.maxX = Math.max(res.maxX, pointArr.maxX);
						res.minY = Math.min(res.minY, pointArr.minY);
						res.maxY = Math.max(res.maxY, pointArr.minY);		
							
						if (res.shapes[label] == null) res.shapes[label] = [];
						(res.shapes[label] as Array).push(pointArr);
					}
					i = e;
					
				} else if (b > -1 && (b < a || a == -1)) {
					
					i = b;
					e = svg.indexOf('>', i);
					a = svg.indexOf('inkscape:label="', i);
					b = svg.indexOf(' d="', i);
					
					
					if (a < e && b < e) {
						// found label and points
						label = svg.substring(a + 16, svg.indexOf('"', a + 16));
						points = svg.substring(b + 4, svg.indexOf('"', b + 4));
						
						var shapes:Array = [];
						
						points = StringUtil.replace(points.toLowerCase(), 'm', '');
						
						if (points.indexOf('z') == -1) trace('z not found in Path');
						
						var shapes_arr:Array = points.split('z');
						// trace(label+':  found ' + (shapes_arr.length-1) + ' subshapes');
						
						for each (var shape_str:String in shapes_arr) {
							if (shape_str != '') {
								pointArr = new PointList();
								p2_arr = shape_str.split('l');							
								// trace(label + ':  found ' + p2_arr.length + ' points in subshape');
								
								if (p2_arr.length > 0) {
									for each (p1_str in p2_arr) {
										if (StringUtil.trim(p1_str) == '') continue;
										p1_arr = p1_str.split(',');
										// trace('p1_arr:', p1_arr);
										if (p1_arr.length != 2) throw new Error(p1_str+' ('+label+')\n'+points);
									
										
										p = new Point(Number(p1_arr[0]), Number(p1_arr[1]));
										if (isNaN(p.x) || isNaN(p.y)) {
											throw new Error('invalid point');
										}
										
										pointArr.push(p);
									}
									if (pointArr.length > 0) {
										res.minX = Math.min(res.minX, pointArr.minX);
										res.maxX = Math.max(res.maxX, pointArr.maxX);
										res.minY = Math.min(res.minY, pointArr.minY);
										res.maxY = Math.max(res.maxY, pointArr.minY);	
										
										shapes.push(pointArr);
									} else {
										trace('no points for ' + label);
									}
								} else {
									//trace(shape_str);
								}
							}
						}
						if (res.shapes[label] == null) res.shapes[label] = [];
						if (shapes.length > 0) {
							// trace(label + ':  added ' + shapes.length + ' complex polygons');
							(res.shapes[label] as Array).push(shapes);
						}
						
					}
					i = e;
					// break;
				}
				
			} while (a > -1 || b > -1);
			
			trace('res.minX:',res.minX);
			
			return res;
		}
		
	}
	
}