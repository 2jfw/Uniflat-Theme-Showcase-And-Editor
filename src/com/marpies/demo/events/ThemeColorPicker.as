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
	import com.marpies.utils.HorizontalLayoutBuilder;

	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.extensions.color.ColorPicker;

	import starling.events.Event;


	public class ThemeColorPicker extends LayoutGroup
	{

		private var _label : String;
		private var _colorPicker : ColorPicker;
		private var _colorChangeVO : ColorChangeVO = new ColorChangeVO();


		public function ThemeColorPicker(id : int,
		                                 label : String)
		{
			super();

			_colorChangeVO.ID = id;
			_label            = label;
		}


		override protected function initialize() : void
		{
			super.initialize();

			layout = new HorizontalLayoutBuilder()
					.setGap(10)
					.setPadding(10)
					.build();

			var label : Label = new Label();
			label.text        = _label;

			addChild(label);


			_colorPicker = new ColorPicker();
			addChild(_colorPicker);

			_colorPicker.colorText.addEventListener(Event.CHANGE,
			                                        onChangeColor); // colorpicker itself should dispatch change event rather than subcomponent
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
