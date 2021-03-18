package com.marpies.demo.display
{

	import com.marpies.demo.enums.ThemeOptionsMenuAction;
	import com.marpies.demo.events.OptionsEvent;
	import com.marpies.utils.Assets;
	import com.marpies.utils.Constants;

	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;

	import starling.events.Event;


	public class ExportThemeList extends List
	{

		public function ExportThemeList()
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

			clipContent = false;
			addEventListener(Event.CHANGE,
			                 onMenuChanged);

			selectedIndex = -1;
		}


		public function createDP() : void
		{
			dataProvider = new ListCollection(
					[
						{
							action: ThemeOptionsMenuAction.SAVE_JSON_CLIPBOARD,
							label:  "Copy JSON to Clipboard",
							icon:   Assets.getTexture("content-copy-icon")
						},
						{
							action: ThemeOptionsMenuAction.SAVE_CLASS_CLIPBOARD,
							label:  "Copy as3 Code to Clipboard",
							icon:   Assets.getTexture("content-copy-icon")
						},
						{
							action: ThemeOptionsMenuAction.SAVE_JSON_DISK,
							label:  "Save JSON to Disk",
							icon:   Assets.getTexture("save-icon")
						},
						{
							action: ThemeOptionsMenuAction.LOAD_JSON_CLIPBOARD,
							label:  "Import JSON from Clipboard",
							icon:   Assets.getTexture("content-paste-icon")
						},
						{
							action: ThemeOptionsMenuAction.LOAD_JSON_DISK,
							label:  "Load JSON from Disk",
							icon:   Assets.getTexture("open-in-new-icon")
						},
						{
							action: ThemeOptionsMenuAction.RESET,
							label:  "Reset to Default",
							icon:   Assets.getTexture("refresh-icon")
						}
					]);
		}


		private function onMenuChanged(event : Event) : void
		{
			if (selectedItem)
			{
				dispatchEventWith(OptionsEvent.CHANGE,
				                  false,
				                  {action: selectedItem.action});

				selectedIndex = -1; // simulating requireSelection=false;
			}
		}
	}
}
