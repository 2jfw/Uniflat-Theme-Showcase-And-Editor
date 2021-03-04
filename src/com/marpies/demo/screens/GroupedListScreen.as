package com.marpies.demo.screens
{

	import feathers.controls.GroupedList;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;


	public class GroupedListScreen extends BaseScreen
	{

		public function GroupedListScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title  = "GROUPED LIST";
			layout = new AnchorLayout();

			const list : GroupedList = new GroupedList();
			list.dataProvider        = new HierarchicalCollection(listData);
			list.isSelectable        = true;
			list.clipContent         = false;
			list.layoutData          = new AnchorLayoutData(0,
			                                                0,
			                                                10,
			                                                0);
			list.itemRendererFactory = function () : IGroupedListItemRenderer {
				var item : DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				item.isQuickHitAreaEnabled                = true;
				item.labelField                           = "text";
				return item;
			};
			addChild(list);
		}


		private function get listData() : Array
		{
			return [
				{
					header:   "A",
					children: [
						{text: "Aardvark"},
						{text: "Alligator"},
						{text: "Alpaca"},
						{text: "Anteater"}
					]
				},
				{
					header:   "B",
					children: [
						{text: "Baboon"},
						{text: "Bear"},
						{text: "Beaver"}
					]
				},
				{
					header:   "C",
					children: [
						{text: "Canary"},
						{text: "Cat"}
					]
				},
				{
					header:   "D",
					children: [
						{text: "Deer"},
						{text: "Dingo"},
						{text: "Dog"},
						{text: "Dolphin"},
						{text: "Donkey"},
						{text: "Dragonfly"},
						{text: "Duck"},
						{text: "Dung Beetle"}
					]
				},
				{
					header:   "E",
					children: [
						{text: "Eagle"},
						{text: "Earthworm"},
						{text: "Eel"},
						{text: "Elk"}
					]
				},
				{
					header:   "F",
					children: [
						{text: "Fox"}
					]
				}
			];
		}

	}

}
