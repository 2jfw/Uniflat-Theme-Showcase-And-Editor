package com.marpies.demo.events
{

	import starling.events.Event;


	public class ScreenEvent extends Event
	{

		public static const TOGGLE_MENU : String = "toggleMenu";
		public static const SWITCH : String      = "switch";


		public function ScreenEvent(type : String,
		                            bubbles : Boolean = false,
		                            data : Object     = null)
		{
			super(type,
			      bubbles,
			      data);
		}

	}

}
