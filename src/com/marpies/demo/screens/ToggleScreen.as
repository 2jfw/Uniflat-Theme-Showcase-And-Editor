package com.marpies.demo.screens
{

	import com.marpies.utils.HorizontalLayoutBuilder;
	import com.marpies.utils.VerticalLayoutBuilder;

	import feathers.controls.Check;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Radio;
	import feathers.controls.ToggleSwitch;
	import feathers.core.IToggle;
	import feathers.core.ToggleGroup;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;


	public class ToggleScreen extends BaseScreen
	{

		public function ToggleScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title  = "TOGGLES";
			layout = new VerticalLayoutBuilder()
					.setGap(20)
					.setPadding(10)
					.setHorizontalAlign(HorizontalAlign.CENTER)
					.setVerticalAlign(VerticalAlign.MIDDLE)
					.build();
			styleNameList.add("j");

			const horizontalLayout : HorizontalLayout = new HorizontalLayoutBuilder().setGap(20).build();

			/* Check boxes */
			const enabledCheckGroup : LayoutGroup = new LayoutGroup();
			enabledCheckGroup.layout              = horizontalLayout;
			enabledCheckGroup.addChild(getCheck({label: "CHECK 1"}));
			enabledCheckGroup.addChild(getCheck({label: "CHECK 2"}));
			addChild(enabledCheckGroup);

			const disabledCheckGroup : LayoutGroup = new LayoutGroup();
			disabledCheckGroup.layout              = horizontalLayout;
			disabledCheckGroup.addChild(getCheck({label: "DISABLED", disabled: true}));
			disabledCheckGroup.addChild(getCheck({label: "DISABLED SELECTED", disabled: true, selected: true}));
			addChild(disabledCheckGroup);

			/* Radio buttons */
			const enabledRadioGroup : LayoutGroup = new LayoutGroup();
			enabledRadioGroup.layout              = horizontalLayout;
			enabledRadioGroup.addChild(getRadio({label: "RADIO 1"}));
			enabledRadioGroup.addChild(getRadio({label: "RADIO 2"}));
			addChild(enabledRadioGroup);

			const disabledRadioGroup : LayoutGroup  = new LayoutGroup();
			disabledRadioGroup.layout               = horizontalLayout;
			const disabledToggleGroup : ToggleGroup = new ToggleGroup();
			disabledRadioGroup.addChild(getRadio({label: "DISABLED", disabled: true},
			                                     disabledToggleGroup));
			disabledRadioGroup.addChild(getRadio({label: "DISABLED SELECTED", disabled: true, selected: true},
			                                     disabledToggleGroup));
			addChild(disabledRadioGroup);

			/* Toggle switches */
			const toggleGroup : LayoutGroup = new LayoutGroup();
			toggleGroup.layout              = horizontalLayout;
			toggleGroup.addChild(getToggle({}));
			toggleGroup.addChild(getToggle({disabled: true}));
			toggleGroup.addChild(getToggle({disabled: true, selected: true}));
			addChild(toggleGroup);
		}


		/**
		 *
		 *
		 * Helpers
		 *
		 *
		 */

		private function getCheck(properties : Object) : Check
		{
			const check : Check = new Check();
			check.label         = properties.label;
			if ("selected" in properties)
			{
				IToggle(check).isSelected = true;
			}
			check.isEnabled = !("disabled" in properties);
			return check;
		}


		private function getRadio(properties : Object,
		                          group : ToggleGroup = null) : Radio
		{
			const radio : Radio = new Radio();
			radio.label         = properties.label;
			if (group)
			{
				radio.toggleGroup = group;
			}
			if ("selected" in properties)
			{
				IToggle(radio).isSelected = true;
			}
			radio.isEnabled = !("disabled" in properties);
			return radio;
		}


		private function getToggle(properties : Object) : ToggleSwitch
		{
			const toggle : ToggleSwitch = new ToggleSwitch();
			if ("selected" in properties)
			{
				IToggle(toggle).isSelected = true;
			}
			toggle.isEnabled = !("disabled" in properties);
			return toggle;
		}

	}

}
