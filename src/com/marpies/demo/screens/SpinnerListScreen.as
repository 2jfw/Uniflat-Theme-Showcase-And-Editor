package com.marpies.demo.screens
{

	import com.marpies.utils.VerticalLayoutBuilder;

	import feathers.controls.DateTimeSpinner;
	import feathers.controls.SpinnerList;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;


	public class SpinnerListScreen extends BaseScreen
	{

		public function SpinnerListScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title = "SPINNER LIST";
			styleNameList.add("j");

			layout = new VerticalLayoutBuilder()
					.setGap(10)
					.setPadding(10)
					.setVerticalAlign(VerticalAlign.MIDDLE)
					.setHorizontalAlign(HorizontalAlign.CENTER)
					.build();

			var list : SpinnerList   = new SpinnerList();
			list.dataProvider        = new ListCollection(
					[
						{text: "AARDVARK"},
						{text: "ALLIGATOR"},
						{text: "ALPACA"},
						{text: "ANTEATER"},
						{text: "BABOON"},
						{text: "BEAR"},
						{text: "BEAVER"},
						{text: "CANARY"},
						{text: "CAT"},
						{text: "DEER"},
						{text: "DINGO"},
						{text: "DOG"},
						{text: "DOLPHIN"},
						{text: "DONKEY"},
						{text: "DRAGONFLY"},
						{text: "DUCK"},
						{text: "DUNG BEETLE"},
						{text: "EAGLE"},
						{text: "EARTHWORM"},
						{text: "EEL"},
						{text: "ELK"},
						{text: "FOX"}
					]);
			list.typicalItem         = {text: "DUNG BEETLE"};
			list.itemRendererFactory = function () : IListItemRenderer {
				var renderer : DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.isQuickHitAreaEnabled         = true;
				renderer.labelField                    = "text";
				return renderer;
			};
			addChild(list);

			var date : DateTimeSpinner = new DateTimeSpinner();
			addChild(date);
		}
	}

}
