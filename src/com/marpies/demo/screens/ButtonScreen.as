package com.marpies.demo.screens
{

	import com.marpies.utils.Assets;
	import com.marpies.utils.HorizontalLayoutBuilder;
	import com.marpies.utils.VerticalLayoutBuilder;

	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.PickerList;
	import feathers.controls.ToggleButton;
	import feathers.core.IToggle;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalAlign;

	import starling.display.Image;


	public class ButtonScreen extends BaseScreen
	{

		private const buttons : Vector.<Object> = new <Object>[
			/* Regular, Quiet */
			{objectClass: Button, label: "REGISTER"},
			{objectClass: Button, label: "DISABLED", disabled: true},
			{objectClass: Button, label: "FAVORITE", icon: Assets.getTexture("favorite-icon")},
			{objectClass: Button, label: "REMOVE", icon: Assets.getTexture("remove-circle-icon"), disabled: true},
			{objectClass: Button, label: "FAVORITE", icon: Assets.getTexture("favorite-icon"), style: "b"},
			{
				objectClass: Button,
				label:       "DISABLED",
				icon:        Assets.getTexture("favorite-icon"),
				style:       "b",
				disabled:    true
			},
			{objectClass: Button, label: "FAVORITE", icon: Assets.getTexture("favorite-icon"), style: "c"},
			{
				objectClass: Button,
				label:       "DISABLED",
				icon:        Assets.getTexture("favorite-icon"),
				style:       "c",
				disabled:    true
			},
			{objectClass: Button, label: "QUIET", style: Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON},
			{objectClass: Button, label: "DISABLED", disabled: true, style: Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON},
			{objectClass: Button, label: "QUIET", style: "d"},
			{objectClass: Button, label: "DISABLED", disabled: true, style: "d", newLine: true},
			/* Call to action */
			{
				objectClass: Button,
				label:       "STORE",
				icon:        Assets.getTexture("shop-icon"),
				style:       Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON
			},
			{
				objectClass: Button,
				label:       "DISABLED",
				icon:        Assets.getTexture("shop-icon"),
				style:       Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON,
				disabled:    true
			},
			{
				objectClass: Button,
				label:       "BACKUP",
				icon:        Assets.getTexture("backup-icon"),
				style:       Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON
			},
			{
				objectClass: Button,
				label:       "ACCOUNT",
				icon:        Assets.getTexture("account-child-icon"),
				style:       Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON,
				disabled:    true
			},
			/* Back, Forward, Toggle */
			{objectClass: Button, label: "BACK", style: Button.ALTERNATE_STYLE_NAME_BACK_BUTTON},
			{objectClass: Button, label: "DISABLED", style: Button.ALTERNATE_STYLE_NAME_BACK_BUTTON, disabled: true},
			{objectClass: Button, label: "FORWARD", style: Button.ALTERNATE_STYLE_NAME_FORWARD_BUTTON},
			{objectClass: Button, label: "DISABLED", style: Button.ALTERNATE_STYLE_NAME_FORWARD_BUTTON, disabled: true},
			{objectClass: ToggleButton, label: "TOGGLE"},
			{objectClass: ToggleButton, label: "DISABLED", selected: true, disabled: true},
			/* Small */
			{objectClass: Button, label: "SMALL", style: "a"},
			{objectClass: Button, label: "DISABLED", style: "a", disabled: true}
		];


		public function ButtonScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title  = "BUTTONS";
			layout = new VerticalLayoutBuilder()
					.setGap(10)
					.setPadding(10)
					.setHorizontalAlign(HorizontalAlign.CENTER)
					.build();
			styleNameList.add("j");

			/* Add PickerList */
			addPickerList();

			/* Add Buttons */
			var mod : int     = 2;
			var horizontalGroup : LayoutGroup;
			var length : uint = buttons.length;
			for (var i : uint = 0; i < length;)
			{
				if (!horizontalGroup)
				{
					horizontalGroup        = new LayoutGroup();
					horizontalGroup.layout = new HorizontalLayoutBuilder().setGap(5).build();
				}
				horizontalGroup.addChild(getButton(buttons[i]));
				if (++i % mod == 0 || i == length)
				{
					addChild(horizontalGroup);
					horizontalGroup = null;
				}
			}

			/* Add ButtonGroup */
			//            addButtonGroup();
		}


		private function addPickerList() : void
		{
			const list : PickerList                                = new PickerList();
			var groceryList : ListCollection                       = new ListCollection(
					[
						{text: "MILK"},
						{text: "EGGS"},
						{text: "BREAD"},
						{text: "CHICKEN"},
						{text: "SALMON"},
						{text: "POTATOES"},
						{text: "LEMONS"},
						{text: "BUTTER"},
						{text: "WINE"}
					]
			);
			list.dataProvider                                      = groceryList;
			list.listProperties.@itemRendererProperties.labelField = "text";
			list.labelField                                        = "text";
			list.prompt                                            = "SELECT";
			list.selectedIndex                                     = -1;
			addChild(list);
		}


		private function getButton(properties : Object) : Button
		{
			const btn : Button = new (Class(properties.objectClass))();
			btn.label          = properties.label;
			if ("style" in properties)
			{
				btn.styleNameList.add(properties.style);
			}
			if ("selected" in properties)
			{
				IToggle(btn).isSelected = true;
			}
			if ("icon" in properties)
			{
				btn.defaultIcon = new Image(properties.icon);
			}
			btn.isEnabled = !("disabled" in properties);
			return btn;
		}

	}

}
