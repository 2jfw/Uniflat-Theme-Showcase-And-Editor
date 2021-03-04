package com.marpies.demo.screens
{

	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;


	public class ListScreen extends BaseScreen
	{

		public function ListScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title  = "LIST";
			layout = new AnchorLayout();
			styleNameList.add("j");

			const items : Array = [];
			for (var i : int = 0; i < 50; i++)
			{
				items[i] = {text: "ITEM " + String(i + 1)};
			}
			items.fixed = true;

			const list : List           = new List();
			list.dataProvider           = new ListCollection(items);
			list.typicalItem            = {text: "ITEM 1000"};
			list.clipContent            = false;
			list.isSelectable           = true;
			list.allowMultipleSelection = true;
			list.itemRendererFactory    = function () : IListItemRenderer {
				var renderer : DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.isQuickHitAreaEnabled         = true;
				renderer.labelField                    = "text";
				return renderer;
			};
			list.layoutData             = new AnchorLayoutData(0,
			                                                   0,
			                                                   0,
			                                                   0);
			addChild(list);
		}
	}

}
