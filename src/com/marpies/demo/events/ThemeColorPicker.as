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


package com.marpies.demo.events
{
	import com.marpies.demo.vo.ColorChangeVO;

	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.extensions.color.ColorPicker;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;

	import starling.display.Quad;
	import starling.events.Event;


	public class ThemeColorPicker extends LayoutGroup
	{

		private var _label : String;
		private var _initialValue : uint;
		private var _colorPicker : ColorPicker;
		private var _colorChangeVO : ColorChangeVO = new ColorChangeVO();


		public function ThemeColorPicker(id : int,
		                                 label : String,
		                                 initialValue : uint)
		{
			super();

			_colorChangeVO.ID = id;
			_label            = label;
			_initialValue     = initialValue;
		}


		override protected function initialize() : void
		{
			super.initialize();

			addChild(new Quad(400,
			                  60,
			                  0xc4c4c4));


			var layoutGroup : LayoutGroup = new LayoutGroup();
			//			layoutGroup.autoSizeMode      = AutoSizeMode.CONTENT;

			var horizontalLayout : HorizontalLayout = new HorizontalLayout();
			horizontalLayout.gap                    = 10;
			horizontalLayout.padding                = 10;
			horizontalLayout.horizontalAlign        = HorizontalAlign.RIGHT;
			horizontalLayout.verticalAlign          = VerticalAlign.MIDDLE;
			layoutGroup.layout                      = horizontalLayout;
			layoutGroup.width                       = 400;


			var label : Label = new Label();
			label.text        = _label;

			layoutGroup.addChild(label);


			_colorPicker       = new ColorPicker();
			_colorPicker.color = _initialValue;

			_colorPicker.colorText.addEventListener(Event.CHANGE,
			                                        onChangeColor); // colorpicker itself should dispatch change event rather than subcomponent

			layoutGroup.addChild(_colorPicker);

			addChild(layoutGroup);

		}


		private function onChangeColor(event : Event) : void
		{
			_colorChangeVO.color = parseInt(_colorPicker.hexValue,
			                                16);

			dispatchEvent(new Event(Event.CHANGE,
			                        false,
			                        _colorChangeVO));
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
