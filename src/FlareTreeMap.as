package  
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import net.vis4.color.Color;
	import net.vis4.text.fonts.embedded.QuicksandBold;
	import net.vis4.text.fonts.embedded.QuicksandBook;
	import net.vis4.text.fonts.embedded.QuicksandLight;
	import net.vis4.text.fonts.Font;
	import net.vis4.text.Label;
	import net.vis4.treemap.data.Tree;
	import net.vis4.treemap.data.TreeNode;
	import net.vis4.treemap.display.Sprite3;
	import net.vis4.treemap.TreeMap;
	/**
	 * ...
	 * @author gka
	 */
	public class FlareTreeMap extends GettingStarted 
	{
		
		override protected function renderTree(tree:Tree):void 
		{
			var treemap:TreeMap = new TreeMap(
				tree, 
				new Rectangle(10, 10, stage.stageWidth-20, stage.stageHeight-20), 
				TreeMap.SQUARIFY_LAYOUT,
				myRenderNode,
				myRenderBranch
			);
			
			treemap.render();
			addChild(treemap);
		}
		
		private var colorIndex:uint = 0;
		
		protected function myRenderNode(node:TreeNode, container:Sprite, level:uint):void
		{
			node.layout.color = node.parent.layout.color;
			
			container.graphics.lineStyle(0, Color.fromInt(node.layout.color,'hsv').value('*0.8')._int);
			container.graphics.beginFill(node.layout.color);
			container.graphics.drawRect(node.layout.x, node.layout.y, node.layout.width, node.layout.height);
		}
		
		protected function myRenderBranch(node:TreeNode, container:Sprite3, level:uint):void 
		{
			if (level == 1) {
				node.layout.color = Color.fromHSV(colorIndex++/10 * 360, Math.random() * .3 + .6, Math.random() * .4 + .4)._int;
				
				
				
			} else if (level > 1) {
				node.layout.color = Color.fromInt(node.parent.layout.color).lightness('+'+(Math.random()*.1-.05))._int;
			}
			
			var labelFont:Class = level < 2 ? QuicksandBold : level < 3 ? QuicksandBook : QuicksandLight;
			var labelCol:uint = 0xffffff;
			var landscape:Boolean = node.layout.width > node.layout.height;
				var label:Label = new Label(node.data.name, new labelFont( { color: labelCol } )).attr({ alpha: level < 4 ? .5 : .7 }).place(0,0,container.fg);
					
				
				
				if (landscape) {
					
					label.scaleY = label.scaleX = Math.min(node.layout.width / label.width, node.layout.height / label.height) * 0.9;
					
					label.x = node.layout.x + (node.layout.width - label.width) * .5;
					label.y = node.layout.y + (node.layout.height - label.height) * .5;
					
				} else {
					
					label.scaleY = label.scaleX = Math.min(node.layout.width / label.height, node.layout.height / label.width) * 0.9;
					
					label.rotation = -90;
					label.x = node.layout.x + (node.layout.width - label.width) * .5;
					label.y = node.layout.y + node.layout.height - (node.layout.height - label.height) * .5;

				}
				
				if (label.scaleX < .5) label.visible = false;
				if (labelFont != QuicksandLight) label.filters = [new DropShadowFilter(2, 45, 0, .3, 16, 16, 2, 3)];
				if (level == 0) label.alpha = .3;
		}
	}

}