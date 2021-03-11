package com.marpies.demo.display
{

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
			clipContent         = false;
			addEventListener(Event.CHANGE,
			                 onMenuChanged);

		}


		public function createDP() : void
		{
			dataProvider = new ListCollection(
					[
						{
							action: 1,
							label:  "Export JSON",
							icon:   Assets.getTexture("save-icon")
						},
						{
							action: 2,
							label:  "Import JSON",
							icon:   Assets.getTexture("load-icon")
						}
					]);
		}


		private function onMenuChanged(event : Event) : void
		{
			if (selectedItem)
			{
				const action : int = selectedItem.action as int;

				if (action == 1)
				{
					trace(Constants.uniflatMobileThemeColors.to);
				}
			}
		}
	}
}
