package com.marpies.demo.screens
{

	import com.marpies.demo.events.ScreenEvent;
	import com.marpies.utils.Assets;

	import feathers.controls.Button;
	import feathers.controls.PanelScreen;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;


	public class BaseScreen extends PanelScreen
	{

		protected var mMenuButton : Button;


		public function BaseScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			/* Add default menu button to the header */
			mMenuButton             = new Button();
			mMenuButton.defaultIcon = new Image(Assets.getTexture("menu-icon"));
			mMenuButton.styleNameList.add("f");
			mMenuButton.addEventListener(Event.TRIGGERED,
			                             onMenuButtonTriggered);
			headerProperties.leftItems = new <DisplayObject>[
				mMenuButton
			];
			backButtonHandler          = onBackButton;
		}


		private function onMenuButtonTriggered() : void
		{
			toggleMenu();
		}


		private function onBackButton() : void
		{
			toggleMenu();
		}


		private function toggleMenu() : void
		{
			dispatchEventWith(ScreenEvent.TOGGLE_MENU);
		}

	}

}
