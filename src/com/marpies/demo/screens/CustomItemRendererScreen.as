package com.marpies.demo.screens
{

	import com.marpies.utils.Constants;
	import com.marpies.utils.VerticalLayoutBuilder;

	import feathers.controls.Check;
	import feathers.controls.GroupedList;
	import feathers.controls.PickerList;
	import feathers.controls.Slider;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayoutData;


	public class CustomItemRendererScreen extends BaseScreen
	{

		public function CustomItemRendererScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title = "ITEM RENDERER";

			layout      = new VerticalLayoutBuilder()
					.setGap(20)
					.build();
			clipContent = false;

			/* Settings list */
			var list : GroupedList = new GroupedList();
			list.dataProvider      = new HierarchicalCollection(
					[
						{
							header:   {label: "SOUND"},
							children: [
								{label: "Music", control: getToggleSwitch()},
								{label: "Effects", control: getToggleSwitch()},
								{label: "Master volume", control: getSlider()}
							],
							footer:   {label: "NOTE: OUR SOUNDTRACK IS A BEAUTY."}
						},
						{
							header:   {label: "GRAPHICS"},
							children: [
								{label: "Particle effects", control: getParticleEffectsList()},
								{label: "Anti-aliasing", control: getAntiAliasList()},
								{label: "Shadows", control: getToggleSwitch()}
							]
						},
						{
							header:   {label: "MISCELLANEOUS"},
							children: [
								{label: "Auto-save", control: getCheckBox()},
								{label: "Upload saves to cloud", control: getCheckBox()}
							]
						}
					]
			);
			list.itemRendererFactory = function () : IGroupedListItemRenderer {
				const item : DefaultGroupedListItemRenderer = new DefaultGroupedListItemRenderer();
				item.labelField                             = "label";
				item.accessoryField                         = "control";
				return item;
			};
			list.layoutData          = new VerticalLayoutData(100);
			list.clipContent         = false;
			list.isSelectable        = false;
			list.hasElasticEdges     = false;
			list.paddingBottom       = 10;
			addChild(list);
		}


		/**
		 *
		 *
		 * Helpers
		 *
		 *
		 */

		private function getSlider() : Slider
		{
			const slider : Slider = new Slider();
			slider.width          = Constants.stageWidth * 0.33;
			slider.minimum        = 0;
			slider.maximum        = 100;
			slider.step           = 1;
			slider.value          = 72;
			return slider;
		}


		private function getCheckBox() : Check
		{
			const check : Check = new Check();
			check.isSelected    = Math.random() > 0.5;
			return check;
		}


		private function getToggleSwitch() : ToggleSwitch
		{
			const toggle : ToggleSwitch = new ToggleSwitch();
			toggle.isSelected           = Math.random() > 0.5;
			return toggle;
		}


		private function getAntiAliasList() : PickerList
		{
			var list : PickerList = new PickerList();
			list.styleNameList.add("k");
			list.dataProvider  = new ListCollection(
					[
						{label: "NONE"},
						{label: "2X"},
						{label: "4X"},
						{label: "8X"}
					]
			);
			list.labelField    = "label";
			list.selectedIndex = 2;
			return list;
		}


		private function getParticleEffectsList() : PickerList
		{
			var list : PickerList = new PickerList();
			list.styleNameList.add("k");
			list.dataProvider  = new ListCollection(
					[
						{label: "NONE"},
						{label: "LOW"},
						{label: "MEDIUM"},
						{label: "HIGH"}
					]
			);
			list.labelField    = "label";
			list.selectedIndex = 3;
			return list;
		}

	}

}
