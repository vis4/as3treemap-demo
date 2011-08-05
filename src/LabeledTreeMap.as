package  
{
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import net.vis4.treemap.data.Tree;
	import net.vis4.treemap.data.TreeNode;
	import net.vis4.treemap.display.Sprite3;
	import net.vis4.treemap.TreeMap;
	/**
	 * ...
	 * @author gka
	 */
	[SWF(width="1200", height="800")]
	public class LabeledTreeMap extends ColoredTreeMap 
	{
		override protected function renderTree(tree:Tree):void 
		{
			var treemap:TreeMap = new TreeMap(
				tree, 
				new Rectangle(10, 12, 1180, 780), 
				TreeMap.SQUARIFY_LAYOUT,
				myRenderNode,
				myRenderBranch
			);
			
			treemap.render();
			addChild(treemap);
		}
		
		override protected function myRenderNode(node:TreeNode, container:Sprite, level:uint):void
		{
			super.myRenderNode(node, container, level);
			
			var label:TextField = new TextField();
			label.defaultTextFormat = new TextFormat('Arial', 9, 0);
			label.selectable = false;
			label.autoSize = TextFieldAutoSize.LEFT;
			label.text = node.data.name;
			label.x = node.layout.x + 2;
			label.y = node.layout.y +2;
			label.alpha = .8;
			//if (label.width < node.layout.width && label.height < node.layout.height) {
				container.addChild(label);
			//}
		}
		
	
	}

}