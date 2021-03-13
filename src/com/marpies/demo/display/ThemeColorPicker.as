//############################################################################
//
//	Copyright (c) 202 All Right Reserved, Jan F. Weber
// 
//	This source is subject to Jan F. Weber. 
// 
//	THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY  
//	KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
//	IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A 
//	PARTICULAR PURPOSE. 
// 
//	AUTHOR	    : Jan F. Weber
//	EMAIL 		: 2jfw@gmx.de
//	DATE  		: 2021-03-06
//	DESCRIPTION	: 
//
//############################################################################


package com.marpies.demo.display
{
	import com.marpies.demo.vo.ColorChangeVO;
	import com.marpies.utils.Assets;

	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.TextCallout;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.extensions.color.ColorPicker;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;
	import feathers.themes.BaseUniflatMobileTheme;

	import flash.text.TextFormatAlign;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;


	public class ThemeColorPicker extends LayoutGroup
	{

		private var _label : String;
		private var _initialValue : uint;
		private var _tooltip : String;

		private var _layoutGroup : LayoutGroup;
		private var _infoButton : Button;
		private var _colorPicker : ColorPicker;
		private var _colorChangeVO : ColorChangeVO = new ColorChangeVO();

		private var _elementFormat : ElementFormat = new ElementFormat(new FontDescription(BaseUniflatMobileTheme.FONT_NAME,
		                                                                                   FontWeight.NORMAL,
		                                                                                   FontPosture.NORMAL,
		                                                                                   FontLookup.EMBEDDED_CFF),
		                                                               7,
		                                                               0xcccccc);


		public function ThemeColorPicker(id : int,
		                                 label : String,
		                                 initialValue : uint,
		                                 tooltip : String)
		{
			super();

			_colorChangeVO.ID = id;
			_label            = label;
			_initialValue     = initialValue;
			_tooltip          = tooltip;
		}


		override protected function initialize() : void
		{
			super.initialize();

			addChild(new Quad(600,
			                  70,
			                  0xc4c4c4));


			_layoutGroup = new LayoutGroup();
			//			layoutGroup.autoSizeMode      = AutoSizeMode.CONTENT;

			var horizontalLayout : HorizontalLayout = new HorizontalLayout();
			horizontalLayout.gap                    = 10;
			horizontalLayout.padding                = 10;
			horizontalLayout.horizontalAlign        = HorizontalAlign.RIGHT;
			horizontalLayout.verticalAlign          = VerticalAlign.MIDDLE;
			_layoutGroup.layout                     = horizontalLayout;
			_layoutGroup.width                      = 600;

			_infoButton             = new Button();
			_infoButton.defaultIcon = new Image(Assets.getTexture("info-icon"));
			_infoButton.label       = "INFO";
			_infoButton.addEventListener(Event.TRIGGERED,
			                             onTrigger);

			_layoutGroup.addChild(_infoButton);


			var label : Label = new Label();
			label.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			label.text = _label;

			_layoutGroup.addChild(label);


			_colorPicker       = new ColorPicker();
			_colorPicker.color = _initialValue;

			_layoutGroup.addChild(_colorPicker);

			addChild(_layoutGroup);


			_colorPicker.colorText.addEventListener(Event.CHANGE,
			                                        onChangeColor); // colorpicker itself should dispatch change event rather than subcomponent
		}


		private function showCallout() : void
		{

			function skinnedCalloutFactory() : TextCallout
			{
				var callout : TextCallout = new TextCallout();

				callout.closeOnTouchBeganOutside = true;
				callout.textRendererFactory      = getTextRenderer;
				callout.disposeOnSelfClose       = true;
				callout.disposeContent           = true;

				return callout;
			}

			TextCallout.show(_tooltip,
			                 _infoButton,
			                 null,
			                 false,
			                 skinnedCalloutFactory);
		}


		private function onChangeColor(event : Event) : void
		{
			_colorChangeVO.color = parseInt(_colorPicker.hexValue,
			                                16);

			dispatchEvent(new Event(Event.CHANGE,
			                        false,
			                        _colorChangeVO));
		}


		override public function resetStyleProvider() : void
		{
			super.resetStyleProvider();
		}


		private function onTrigger(event : Event) : void
		{
			showCallout();
		}


		private function getTextRenderer() : ITextRenderer
		{
			var textRenderer : TextBlockTextRenderer = new TextBlockTextRenderer();
			textRenderer.styleProvider               = null; // exp
			textRenderer.elementFormat               = _elementFormat;
			textRenderer.textAlign                   = TextFormatAlign.LEFT;

			return textRenderer;
		}


		override public function dispose() : void // actually never called but anyways..
		{
			super.dispose();

			_colorPicker.colorText.removeEventListener(Event.CHANGE,
			                                           onChangeColor);

			_colorPicker.dispose();
			_colorPicker = null;

			removeChildren();
		}

	}
}
