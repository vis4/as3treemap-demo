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
	public class BranchBorderThickness extends GettingStarted 
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
		
		private function myRenderNode(node:TreeNode, container:Sprite, level:uint):void
		{
			container.graphics.beginFill(0xcccccc);
			container.graphics.drawRect(node.layout.x, node.layout.y, node.layout.width, node.layout.height);
		}
		
		private function myRenderBranch(node:TreeNode, container:Sprite3, level:uint):void 
		{
			if (level > 0) {
				container.fg.graphics.lineStyle(5/level, 0, 1, true, 'normal', CapsStyle.SQUARE);
				container.fg.graphics.drawRect(node.layout.x, node.layout.y, node.layout.width, node.layout.height);
			}
			
		}
		
	}

}