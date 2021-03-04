package
{

	import com.marpies.demo.display.MenuList;
	import com.marpies.demo.events.ScreenEvent;
	import com.marpies.demo.screens.AlertCalloutScreen;
	import com.marpies.demo.screens.AutoCompleteScreen;
	import com.marpies.demo.screens.ButtonScreen;
	import com.marpies.demo.screens.CustomItemRendererScreen;
	import com.marpies.demo.screens.GroupedListScreen;
	import com.marpies.demo.screens.LabelScreen;
	import com.marpies.demo.screens.ListScreen;
	import com.marpies.demo.screens.NumericStepperScreen;
	import com.marpies.demo.screens.PageIndicatorScreen;
	import com.marpies.demo.screens.ProgressBarScreen;
	import com.marpies.demo.screens.Screens;
	import com.marpies.demo.screens.SliderScreen;
	import com.marpies.demo.screens.SpinnerListScreen;
	import com.marpies.demo.screens.TabBarScreen;
	import com.marpies.demo.screens.TextInputsScreen;
	import com.marpies.demo.screens.ToggleScreen;

	import feathers.controls.Drawers;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.layout.RelativeDepth;
	import feathers.themes.UniflatMobileThemeWithIcons;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;


	public class Main extends Sprite
	{

		private var mMenu : MenuList;
		private var mDrawers : Drawers;
		private var mNavigator : StackScreenNavigator;


		public function Main()
		{
			super();
		}


		public function start() : void
		{
			new UniflatMobileThemeWithIcons();

			/* Screen navigator */
			mNavigator = new StackScreenNavigator();
			mNavigator.addScreen(Screens.ALERT_CALLOUT,
			                     new StackScreenNavigatorItem(AlertCalloutScreen));
			mNavigator.addScreen(Screens.AUTO_COMPLETE,
			                     new StackScreenNavigatorItem(AutoCompleteScreen));
			mNavigator.addScreen(Screens.BUTTON,
			                     new StackScreenNavigatorItem(ButtonScreen));
			mNavigator.addScreen(Screens.GROUPED_LIST,
			                     new StackScreenNavigatorItem(GroupedListScreen));
			mNavigator.addScreen(Screens.ITEM_RENDERER,
			                     new StackScreenNavigatorItem(CustomItemRendererScreen));
			mNavigator.addScreen(Screens.LABEL,
			                     new StackScreenNavigatorItem(LabelScreen));
			mNavigator.addScreen(Screens.LIST,
			                     new StackScreenNavigatorItem(ListScreen));
			mNavigator.addScreen(Screens.NUMERIC_STEPPER,
			                     new StackScreenNavigatorItem(NumericStepperScreen));
			mNavigator.addScreen(Screens.PAGE_INDICATOR,
			                     new StackScreenNavigatorItem(PageIndicatorScreen));
			mNavigator.addScreen(Screens.PROGRESS_BAR,
			                     new StackScreenNavigatorItem(ProgressBarScreen));
			mNavigator.addScreen(Screens.SLIDER,
			                     new StackScreenNavigatorItem(SliderScreen));
			mNavigator.addScreen(Screens.SPINNER_LIST,
			                     new StackScreenNavigatorItem(SpinnerListScreen));
			mNavigator.addScreen(Screens.TAB_BAR,
			                     new StackScreenNavigatorItem(TabBarScreen));
			mNavigator.addScreen(Screens.TEXT_INPUT,
			                     new StackScreenNavigatorItem(TextInputsScreen));
			mNavigator.addScreen(Screens.TOGGLE,
			                     new StackScreenNavigatorItem(ToggleScreen));
			mNavigator.rootScreenID = Screens.ALERT_CALLOUT;

			/* Menu list */
			mMenu = new MenuList();
			mMenu.addEventListener(ScreenEvent.SWITCH,
			                       onScreenSwitch);

			/* Drawers */
			mDrawers                           = new Drawers(mNavigator);
			mDrawers.leftDrawer                = mMenu;
			mDrawers.clipDrawers               = true;
			mDrawers.openMode                  = RelativeDepth.ABOVE;
			mDrawers.leftDrawerToggleEventType = ScreenEvent.TOGGLE_MENU;
			addChild(mDrawers);
		}


		private function onScreenSwitch(event : Event) : void
		{
			mNavigator.pushScreen(event.data.screen);
			Starling.juggler.delayCall(mDrawers.toggleLeftDrawer,
			                           0.25);
		}
	}
}
