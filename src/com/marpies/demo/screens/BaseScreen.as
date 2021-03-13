package com.marpies.demo.screens
{

	import com.marpies.demo.events.ScreenEvent;
	import com.marpies.utils.Assets;

	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;


	public class BaseScreen extends PanelScreen
	{

		protected var mMenuButton : Button;


		public function BaseScreen()
		{
			if (!mMenuButton)
			{
				mMenuButton             = new Button();
				mMenuButton.defaultIcon = new Image(Assets.getTexture("menu-icon"));
				mMenuButton.styleNameList.add("f");
				mMenuButton.addEventListener(Event.TRIGGERED,
				                             onMenuButtonTriggered);
			}

			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			backButtonHandler = onBackButton;
		}


		override protected function createHeader() : void
		{
			var __header : Header;

			if (header)
			{
				__header = header as Header;
			}

			if (__header && __header.leftItems)
			{
				__header.removeChild(mMenuButton);
				__header.leftItems = null;
			}

			super.createHeader();

			__header           = header as Header;
			__header.leftItems = new <DisplayObject>[mMenuButton];
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
