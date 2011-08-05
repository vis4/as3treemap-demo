package  
{
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import net.vis4.treemap.data.Tree;
	import net.vis4.treemap.data.TreeNode;
	import net.vis4.treemap.display.Sprite3;
	import net.vis4.treemap.TreeMap;
	/**
	 * ...
	 * @author gka
	 */
	public class ColoredTreeMap extends GettingStarted 
	{
		
		override protected function renderTree(tree:Tree):void 
		{
			var treemap:TreeMap = new TreeMap(
				tree, 
				new Rectangle(10, 10, 600, 400), 
				TreeMap.SQUARIFY_LAYOUT,
				myRenderNode,
				myRenderBranch
			);
			
			treemap.render();
			addChild(treemap);
		}
		
		private var myColors:Array = [0xEA5151, 0xEAE251, 0xABE357, 0x59E1CD, 0x5E6DDD, 0xE357E3, 0xB494CD, 0x98C9A5, 0xF9D58A, 0xC1C6BD, 0x7D9FAA];
		
		private var colorIndex:uint = 0;
		
		protected function myRenderNode(node:TreeNode, container:Sprite, level:uint):void
		{
			node.layout.color = node.parent.layout.color;
			
			container.graphics.lineStyle(0, 0xffffff);
			container.graphics.beginFill(node.layout.color);
			container.graphics.drawRect(node.layout.x, node.layout.y, node.layout.width, node.layout.height);
		}
		
		protected function myRenderBranch(node:TreeNode, container:Sprite3, level:uint):void 
		{
			if (level == 1) {
				node.layout.color = myColors[colorIndex++ % myColors.length];
			} else if (level > 1) {
				node.layout.color = node.parent.layout.color;
			}
		}
		
	}

}