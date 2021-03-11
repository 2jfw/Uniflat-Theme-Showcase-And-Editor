package com.marpies.demo.screens
{
	import com.marpies.demo.display.ThemeColorPicker;
	import com.marpies.demo.enums.UniflatColorTarget;
	import com.marpies.demo.events.ScreenEvent;
	import com.marpies.demo.vo.ThemeColors;
	import com.marpies.utils.Assets;
	import com.marpies.utils.VerticalLayoutBuilder;

	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScrollPolicy;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayoutData;
	import feathers.themes.BaseUniflatMobileTheme;

	import flash.text.TextFormatAlign;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;


	public class ThemeColorConfigurationScreen extends BaseScreen
	{

		private var _elementFormat : ElementFormat = new ElementFormat(new FontDescription(BaseUniflatMobileTheme.FONT_NAME,
		                                                                                   FontWeight.NORMAL,
		                                                                                   FontPosture.NORMAL,
		                                                                                   FontLookup.EMBEDDED_CFF),
		                                                               20,
		                                                               0xcccccc);


		public function ThemeColorConfigurationScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			scaleX = scaleY = .35;
			title  = "THEME COLORS";
			layout = new VerticalLayoutBuilder()
					.setGap(10)
					.setHorizontalAlign(HorizontalAlign.RIGHT)
					.build();

			layoutData = new HorizontalLayoutData(100,
			                                      NaN);

			horizontalScrollPolicy = ScrollPolicy.OFF;

			styleNameList.add("j");

			createColorSettings();
			createOptionsButton();
		}


		private function createColorSettings() : void
		{
			var ids : Vector.<int> = new <int>[UniflatColorTarget.PRIMARY_MAIN,
			                                   UniflatColorTarget.PRIMARY_DISABLED,
			                                   UniflatColorTarget.PRIMARY_CONSTRAST,
			                                   UniflatColorTarget.PRIMARY_CONSTRAST_DISABLED,

			                                   UniflatColorTarget.ALTERNATIVE_MAIN,
			                                   UniflatColorTarget.ALTERNATIVE_DISABLED,
			                                   UniflatColorTarget.ALTERNATIVE_CONSTRAST,
			                                   UniflatColorTarget.ALTERNATIVE_CONSTRAST_DISABLED,

			                                   UniflatColorTarget.MISC_STAGE,
			                                   UniflatColorTarget.MISC_BACKGROUND,
			                                   UniflatColorTarget.MISC_CONTRAST,
			                                   UniflatColorTarget.MISC_CONSTRAST_DISABLED
			];


			var initialColor : Vector.<int> = new <int>[ThemeColors.COLOR_PRIMARY,
			                                            ThemeColors.COLOR_PRIMARY_DISABLED,
			                                            ThemeColors.COLOR_PRIMARY_CONTRAST,
			                                            ThemeColors.COLOR_PRIMARY_CONTRAST_DISABLED,

			                                            ThemeColors.COLOR_ALTERNATIVE,
			                                            ThemeColors.COLOR_ALTERNATIVE_DISABLED,
			                                            ThemeColors.COLOR_ALTERNATIVE_CONTRAST,
			                                            ThemeColors.COLOR_ALTERNATIVE_CONTRAST_DISABLED,

			                                            ThemeColors.COLOR_STAGE,
			                                            ThemeColors.COLOR_BACKGROUND,
			                                            ThemeColors.COLOR_CONTRAST,
			                                            ThemeColors.COLOR_CONTRAST_DISABLED
			];

			var labels : Vector.<String> = new <String>["MAIN",
			                                            "DISABLED",
			                                            "CONTRAST",
			                                            "CONSTRAST DISABLED",

			                                            "MAIN",
			                                            "DISABLED",
			                                            "CONTRAST",
			                                            "CONSTRAST DISABLED",

			                                            "STAGE",
			                                            "BACKGROUND",
			                                            "CONTRAST",
			                                            "CONSTRAST DISABLED"];

			var tooltips : Vector.<String> = new <String>["Used for primary buttons, selected state of toggles (Check, Radio...)",
			                                              "Used for disabled state of primary buttons",
			                                              "Used for text where PRIMARY MAIN color is used, and for PanelScreen header title",
			                                              "Used for text where PRIMARY DISABLED color is used",

			                                              "Alternative color, used for call-to-action and alternative buttons",
			                                              "Used for disabled state of call-to-action and alternative buttons",
			                                              "Used for text where ALTERNATIVE MAIN color is used",
			                                              "Used for text where ALTERNATIVE DISABLED color is used",

			                                              "Used for the stage color",
			                                              "Used for background skin (List, GroupedList, Alert...)",
			                                              "Used for TextRenderers (Label, ItemRenderer...), deselected toggle states (Check, Radio), PanelScreen header background, overlay (Drawers, pop up)",
			                                              "Used for disabled state of TextRenderers (Label, ItemRenderer...), toggles (Check, Radio)"];

			var label : Label;
			var themeColorPicker : ThemeColorPicker;
			var len : int = labels.length;

			for (var i : int = 0; i < len; i++) // a little dirty
			{
				if (i == 0 || i == 4 || i == 8)
				{
					label = new Label();

					label.textRendererFactory = getTextRenderer;

					var labelLayoutData : AnchorLayoutData = new AnchorLayoutData();
					labelLayoutData.percentWidth           = 100;
					label.layoutData                       = labelLayoutData;
					label.paddingRight                     = 10;

					addChild(label);

					if (i == 0)
					{
						label.text = "PRIMARY";
					}
					else if (i == 4)
					{
						label.text = "ALTERNATIVE";
					}
					else
					{
						label.text = "MISC";
					}
				}


				themeColorPicker = new ThemeColorPicker(ids[i],
				                                        labels[i],
				                                        initialColor[i],
				                                        tooltips[i]);

				themeColorPicker.addEventListener(Event.CHANGE,
				                                  onChangeColor);

				addChild(themeColorPicker);
			}

			label      = new Label();
			label.text = "Callout";
		}


		private function createOptionsButton() : void
		{
			var optionsButton : Button = new Button();
			optionsButton.defaultIcon  = new Image(Assets.getTexture("settings-icon"));
			optionsButton.styleNameList.add("f");

			optionsButton.addEventListener(Event.TRIGGERED,
			                               onTriggerOptionsButton);

			headerProperties.rightItems = new <DisplayObject>[
				optionsButton
			];
		}


		private function onTriggerOptionsButton() : void
		{
			showOptions();
		}


		private function showOptions() : void
		{
			dispatchEventWith(ScreenEvent.TOGGLE_MENU);
		}


		private function getTextRenderer() : ITextRenderer
		{
			var textRenderer : TextBlockTextRenderer = new TextBlockTextRenderer();
			textRenderer.styleProvider               = null; // exp
			textRenderer.elementFormat               = _elementFormat;
			textRenderer.textAlign                   = TextFormatAlign.LEFT;

			return textRenderer;
		}


		private function onChangeColor(event : Event) : void
		{
			_owner.dispatchEvent(event);
		}
	}
}
