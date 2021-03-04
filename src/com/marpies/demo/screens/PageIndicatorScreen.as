package com.marpies.demo.screens
{

	import feathers.controls.PageIndicator;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;


	public class PageIndicatorScreen extends BaseScreen
	{

		public function PageIndicatorScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title  = "PAGE INDICATOR";
			layout = new AnchorLayout();

			const pageIndicator : PageIndicator            = new PageIndicator();
			pageIndicator.pageCount                        = 6;
			var pageIndicatorLayoutData : AnchorLayoutData = new AnchorLayoutData();
			pageIndicatorLayoutData.verticalCenter         = 0;
			pageIndicatorLayoutData.horizontalCenter       = 0;
			pageIndicator.layoutData                       = pageIndicatorLayoutData;
			addChild(pageIndicator);
		}

	}

}
