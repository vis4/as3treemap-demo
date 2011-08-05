package 
{
	import com.adobe.serialization.json.JSON;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import net.vis4.treemap.data.*;
	import net.vis4.treemap.events.TreeMapBranchEvent;
	import net.vis4.treemap.events.TreeMapEvent;
	import net.vis4.treemap.layout.RecursiveSquarifyLayout;
	import net.vis4.treemap.layout.SliceAndDiceLayout;
	import net.vis4.treemap.layout.SquarifyLayout;
	import net.vis4.treemap.layout.StripLayout;
	import net.vis4.treemap.TreeMap;
	
	/**
	 * ...
	 * @author gka
	 */
	public class GettingStarted extends Sprite 
	{
		
		public function GettingStarted():void 
		{
			var ldr:URLLoader = new URLLoader();
			ldr.addEventListener(Event.COMPLETE, dataLoaded);
			ldr.load(new URLRequest('flare.json'));
		}
		
		protected function dataLoaded(e:Event):void 
		{
			var data:Object = JSON.decode((e.target as URLLoader).data);
			var tree:Tree = new Tree(parseFlareTree(data));
			
			renderTree(tree);
		}
		
		protected function parseFlareTree(data:Object):TreeNode 
		{
			var node:TreeNode = new TreeNode(data, data.children ? 0 : data.size);
			for each (var childData:Object in data.children) {
				var child:TreeNode = parseFlareTree(childData);
				node.weight += child.weight;
				node.addChild(child);
			}
			return node;
		}
		
				
		protected function renderTree(tree:Tree):void 
		{
			var treemap:TreeMap = new TreeMap(
				tree, 
				new Rectangle(10, 10, 600, 400), 
				TreeMap.SQUARIFY_LAYOUT
			);
			
			treemap.render();
			addChild(treemap);
		}
		
		
	}
	
}