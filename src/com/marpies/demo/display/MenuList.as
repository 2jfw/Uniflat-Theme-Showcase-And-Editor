package com.marpies.demo.display
{

	import com.marpies.demo.events.ScreenEvent;
	import com.marpies.demo.screens.Screens;
	import com.marpies.utils.Assets;
	import com.marpies.utils.Constants;

	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;

	import starling.events.Event;


	public class MenuList extends List
	{

		public function MenuList()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			createDP();

			minWidth            = Constants.stageWidth >> 2;
			selectedIndex       = 0;
			hasElasticEdges     = false;
			itemRendererFactory = function () : IListItemRenderer {
				const item : DefaultListItemRenderer = new DefaultListItemRenderer();
				item.labelField                      = "label";
				item.iconSourceField                 = "icon";
				return item;
			};
			clipContent         = false;
			addEventListener(Event.CHANGE,
			                 onMenuChanged);
		}


		public function createDP() : void
		{
			dataProvider = new ListCollection(
					[
						{
							screen: Screens.ALERT_CALLOUT,
							label:  "ALERT, CALLOUT",
							icon:   Assets.getTexture("warning-icon")
						},
						{
							screen: Screens.AUTO_COMPLETE,
							label:  "AUTO COMPLETE",
							icon:   Assets.getTexture("receipt-icon")
						},
						{screen: Screens.BUTTON, label: "BUTTONS", icon: Assets.getTexture("view-stream-icon")},
						{screen: Screens.GROUPED_LIST, label: "GROUPED LIST", icon: Assets.getTexture("view-day-icon")},
						{screen: Screens.ITEM_RENDERER, label: "ITEM RENDERER", icon: Assets.getTexture("dns-icon")},
						{screen: Screens.LABEL, label: "LABELS", icon: Assets.getTexture("loyalty-icon")},
						{screen: Screens.LIST, label: "LIST", icon: Assets.getTexture("menu-icon")},
						{
							screen: Screens.NUMERIC_STEPPER,
							label:  "NUMERIC STEPPER",
							icon:   Assets.getTexture("plus-one-icon")
						},
						{
							screen: Screens.PAGE_INDICATOR,
							label:  "PAGE INDICATOR",
							icon:   Assets.getTexture("more-horizontal-icon")
						},
						{screen: Screens.PROGRESS_BAR, label: "PROGRESS BAR", icon: Assets.getTexture("remove-icon")},
						{screen: Screens.SLIDER, label: "SLIDER", icon: Assets.getTexture("settings-ethernet-icon")},
						{screen: Screens.SPINNER_LIST, label: "SPINNER LIST", icon: Assets.getTexture("theaters-icon")},
						{screen: Screens.TAB_BAR, label: "TAB BAR", icon: Assets.getTexture("view-week-icon")},
						{screen: Screens.TEXT_INPUT, label: "TEXT INPUTS", icon: Assets.getTexture("text-format-icon")},
						{screen: Screens.TOGGLE, label: "TOGGLES", icon: Assets.getTexture("check-circle-icon")}
					]);
		}


		private function onMenuChanged(event : Event) : void
		{
			if (selectedItem)
			{
				const screenName : String = selectedItem.screen as String;

				dispatchEventWith(ScreenEvent.SWITCH,
				                  false,
				                  {screen: screenName});
			}
		}
	}
}
