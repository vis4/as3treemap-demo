package net.vis4.data.tsv 
{
	import com.adobe.utils.StringUtil;
	
	/**
	 * ...
	 * @author gka
	 */
	public class TSVParser 
	{
		
		public static function parse(raw:String, asObject:Boolean = false):Array 
		{
			var lines:Array = raw.split("\n");
			var data:Array = [];
			var props:Array;
			var l:uint = 0;
			for each (var line:String in lines) {
				if (line != '') {
					//if (line != lines[lines.length-1]) line = StringUtil.trim(line);
					if (asObject) {
						if (l == 0) props = line.split("\t");
						else {
							var obj:Object = { };
							var values:Array = line.split("\t");
							if (values.length != props.length) {
								throw new Error('invalid TSV format');
							}
							for (var p:uint = 0; p < props.length; p++) {
								obj[StringUtil.trim(props[p])] = StringUtil.trim(values[p]);
							}
							data.push(obj);
						}
					} else {
						data.push(line.split("\t"));
					}
				}
				l++;
			}
			return data;
		}
		
	}
	
}