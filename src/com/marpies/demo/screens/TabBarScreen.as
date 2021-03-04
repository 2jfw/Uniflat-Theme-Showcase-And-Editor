package com.marpies.demo.screens
{

	import com.marpies.utils.Assets;

	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Image;
	import starling.events.Event;


	public class TabBarScreen extends BaseScreen
	{

		private var mLabel : Label;
		private var mLabel2 : Label;
		private var mTabBar : TabBar;
		private var mTabBar2 : TabBar;


		public function TabBarScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title = "TAB BAR";

			layout      = new AnchorLayout();
			clipContent = false; // Avoids occasional white space between the header and the tab bar
			styleNameList.add("j");

			/* Label */
			mLabel = getLabel(-20);
			addChild(mLabel);

			/* Label 2 */
			mLabel2 = getLabel(20);
			addChild(mLabel2);

			/* Top tab bar (with shadow at the bottom) */
			mTabBar = getTabBar(new AnchorLayoutData(0,
			                                         0,
			                                         NaN,
			                                         0),
			                    onTabBarChanged,
			                    "h",
			                    -2);

			/* Bottom tab bar (with shadow at the top) */
			mTabBar2 = getTabBar(new AnchorLayoutData(NaN,
			                                          0,
			                                          0,
			                                          0),
			                     onTabBar2Changed,
			                     "g");

			onTabBarChanged();
			onTabBar2Changed();
		}


		/**
		 *
		 *
		 * Tab bar CHANGE handlers
		 *
		 *
		 */

		private function onTabBarChanged() : void
		{
			mLabel.text = "Selected index: " + mTabBar.selectedIndex;
		}


		private function onTabBar2Changed() : void
		{
			mLabel2.text = "Selected index: " + mTabBar2.selectedIndex;
		}


		/**
		 *
		 *
		 * Helpers
		 *
		 *
		 */

		private function getLabel(verticalCenter : Number) : Label
		{
			const label : Label                      = new Label();
			const labelLayoutData : AnchorLayoutData = new AnchorLayoutData();
			labelLayoutData.horizontalCenter         = 0;
			labelLayoutData.verticalCenter           = verticalCenter;
			label.layoutData                         = labelLayoutData;
			return label;
		}


		private function getTabBar(layoutData : AnchorLayoutData,
		                           changeHandler : Function,
		                           style : String,
		                           tabOffsetY : int = 0) : TabBar
		{
			/* TabBar must be placed inside a LayoutGroup in order to have a background */
			var group : LayoutGroup = new LayoutGroup();
			group.layout            = new AnchorLayout();
			group.layoutData        = layoutData;
			group.styleNameList.add(style);
			/* Icons style must be added to the group to adjust its height */
			group.styleNameList.add("i");
			var tabBar : TabBar = new TabBar();
			tabBar.dataProvider = new ListCollection(
					[
						{label: "FAVORITES", defaultIcon: new Image(Assets.getTexture("favorite-icon"))},
						{label: "ARCHIVES", defaultIcon: new Image(Assets.getTexture("archive-icon"))},
						{label: "SHARE", defaultIcon: new Image(Assets.getTexture("share-icon"))}
					]);
			tabBar.layoutData   = new AnchorLayoutData(NaN,
			                                           NaN,
			                                           NaN,
			                                           NaN,
			                                           0,
			                                           tabOffsetY);
			tabBar.addEventListener(Event.CHANGE,
			                        changeHandler);
			/* Icons style must be added to the tab bar to adjust tab's height */
			tabBar.styleNameList.add("i");
			group.addChild(tabBar);
			addChild(group);
			return tabBar;
		}

	}

}
