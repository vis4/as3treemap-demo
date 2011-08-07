package net.vis4.data.json 
{
	import com.adobe.serialization.json.JSON;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author gka
	 */
	public class JSONLoader 
	{
		private var _onComplete:Function;
		
		public function JSONLoader(url:String, onComplete:Function) 
		{
			_onComplete = onComplete;
			var ldr:URLLoader = new URLLoader();
			ldr.addEventListener(Event.COMPLETE, loaded);
			ldr.load(new URLRequest(url));
		}
		
		private function loaded(e:Event):void 
		{
			try {
				var data:Object = JSON.decode((e.target as URLLoader).data);
				_onComplete(data);
			} catch (er:Error) {
				trace('could not parse');
				trace(er.getStackTrace());
				trace((e.target as URLLoader).data);
			}
		}
		
	}
	
}