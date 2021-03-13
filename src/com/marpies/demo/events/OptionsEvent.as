package com.marpies.demo.events
{

	import starling.events.Event;


	public class OptionsEvent extends Event
	{

		public static const CHANGE : String = "optionsChanged";


		public function OptionsEvent(type : String,
		                             bubbles : Boolean = false,
		                             data : Object     = null)
		{
			super(type,
			      bubbles,
			      data);
		}

	}

}
