package
{

	import com.marpies.demo.display.MenuList;
	import com.marpies.demo.enums.UniflatColorTarget;
	import com.marpies.demo.events.ScreenEvent;
	import com.marpies.demo.screens.AlertCalloutScreen;
	import com.marpies.demo.screens.AutoCompleteScreen;
	import com.marpies.demo.screens.ButtonScreen;
	import com.marpies.demo.screens.CustomItemRendererScreen;
	import com.marpies.demo.screens.EmptyScreen;
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
	import com.marpies.demo.screens.ThemeColorConfigurationScreen;
	import com.marpies.demo.screens.ToggleScreen;
	import com.marpies.demo.vo.ColorChangeVO;
	import com.marpies.demo.vo.ThemeColors;

	import feathers.controls.AutoSizeMode;
	import feathers.controls.Drawers;
	import feathers.controls.LayoutGroup;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.RelativeDepth;
	import feathers.layout.VerticalAlign;
	import feathers.themes.BaseUniflatMobileTheme;
	import feathers.themes.UniflatMobileThemeColors;
	import feathers.themes.UniflatMobileThemeWithIcons;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;


	public class Main extends Sprite
	{

		[Embed(source="/../assets/json/Default.json", mimeType="application/octet-stream")]
		private static const DEFAULT_COLORS_JSON : Class;

		private var mMenu : MenuList;
		private var mDrawers : Drawers;
		private var mNavigator : StackScreenNavigator;
		private var mNavigatorColorization : StackScreenNavigator;
		private var mNavigatorColorizationInitialized : Boolean;

		private var theme : BaseUniflatMobileTheme;
		private var tempEmptryScreen : StackScreenNavigatorItem         = new StackScreenNavigatorItem(EmptyScreen);
		private var uniflatMobileThemeColors : UniflatMobileThemeColors = new UniflatMobileThemeColors();
		private var applyColorTimer : Timer                             = new Timer(250,
		                                                                            1); // this timer prevents too frequent updates. Slightly hackish attempt..
		private var colorChangeVO : ColorChangeVO;


		public function Main()
		{
			super();

			applyColorTimer.addEventListener(TimerEvent.TIMER_COMPLETE,
			                                 onCompleteTimerChangeColor);
		}


		private function initTheme() : void
		{
			// Setting initial values seems to fix an issue where components would become white when changing colors
			changeThemeColors(new ThemeColors().fromJSON(new DEFAULT_COLORS_JSON()).toUniflatMobileThemeColors());
		}


		public function changeThemeColors(value : UniflatMobileThemeColors = null) : void
		{
			if (value)
			{
				uniflatMobileThemeColors = value;
			}

			if (theme)
			{
				theme.dispose();
			}


			theme = new UniflatMobileThemeWithIcons(value);


			if (mNavigator)
			{
				mNavigator.resetStyleProvider();

				resetCurrentScreen(mNavigator);
			}

			//			if (mNavigatorColorization && !mNavigatorColorizationInitialized)
			//			{
			//				mNavigatorColorization.resetStyleProvider();
			//
			//				resetCurrentScreen(mNavigatorColorization);
			//
			//				mNavigatorColorizationInitialized = true;
			//			}


			if (mDrawers)
			{
				mDrawers.resetStyleProvider();
			}

			if (mMenu)
			{
				mMenu.resetStyleProvider();

				mMenu.invalidate();
				mMenu.validate();

				//				mMenu.dataProvider.refresh();
				//				mMenu.createDP();
			}
		}


		/**
		 * This will inject a temporary empty screen, then revert back to the previous screen and finally remove the temporary screen.
		 * There can be better solutions available like e.g. some kind of invalidation which I am unaware of at this point in time
		 */
		private function resetCurrentScreen(feathersControl : StackScreenNavigator) : void
		{
			var lastScreen : String = feathersControl.activeScreenID;

			feathersControl.addScreen(Screens.EMPTY,
			                          tempEmptryScreen);

			feathersControl.pushScreen(Screens.EMPTY);
			feathersControl.pushScreen(lastScreen);
			feathersControl.removeScreen(Screens.EMPTY);
		}


		public function start() : void
		{
			initTheme();

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


			mNavigatorColorization               = new StackScreenNavigator();
			mNavigatorColorization.styleProvider = null;

			mNavigatorColorization.addScreen(Screens.THEME_COLORS,
			                                 new StackScreenNavigatorItem(ThemeColorConfigurationScreen));

			mNavigatorColorization.addEventListener(Event.CHANGE,
			                                        onChangeColor);


			mNavigatorColorization.rootScreenID = Screens.THEME_COLORS;


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


			var layoutGroup : LayoutGroup = new LayoutGroup();
			layoutGroup.autoSizeMode      = AutoSizeMode.STAGE;
			var layout : HorizontalLayout = new HorizontalLayout();
			layout.horizontalAlign        = HorizontalAlign.CENTER;
			layout.verticalAlign          = VerticalAlign.MIDDLE;
			layout.gap                    = 10;

			layoutGroup.layout = layout;
			addChild(layoutGroup);

			var layoutData1 : HorizontalLayoutData = new HorizontalLayoutData();
			layoutData1.percentWidth               = 50;
			mDrawers.layoutData                    = layoutData1;

			var layoutData2 : HorizontalLayoutData = new HorizontalLayoutData();
			layoutData2.percentWidth               = 50;
			mNavigatorColorization.layoutData      = layoutData2;

			layoutGroup.addChild(mDrawers);
			layoutGroup.addChild(mNavigatorColorization);
		}


		private function applyColors() : void
		{
			if (colorChangeVO.ID == UniflatColorTarget.PRIMARY_MAIN)
			{
				uniflatMobileThemeColors.colorPrimary = colorChangeVO.color;
			}
			else if (colorChangeVO.ID == UniflatColorTarget.PRIMARY_DISABLED)
			{
				uniflatMobileThemeColors.colorPrimaryDisabled = colorChangeVO.color;
			}
			else if (colorChangeVO.ID == UniflatColorTarget.PRIMARY_CONSTRAST)
			{
				uniflatMobileThemeColors.colorPrimaryContrast = colorChangeVO.color;
			}
			else if (colorChangeVO.ID == UniflatColorTarget.PRIMARY_DISABLED)
			{
				uniflatMobileThemeColors.colorPrimaryContrastDisabled = colorChangeVO.color;
			}


			else if (colorChangeVO.ID == UniflatColorTarget.ALTERNATIVE_MAIN)
			{
				uniflatMobileThemeColors.colorAlt = colorChangeVO.color;
			}
			else if (colorChangeVO.ID == UniflatColorTarget.ALTERNATIVE_DISABLED)
			{
				uniflatMobileThemeColors.colorAltDisabled = colorChangeVO.color;
			}
			else if (colorChangeVO.ID == UniflatColorTarget.ALTERNATIVE_CONSTRAST)
			{
				uniflatMobileThemeColors.colorAltContrast = colorChangeVO.color;
			}
			else if (colorChangeVO.ID == UniflatColorTarget.ALTERNATIVE_CONSTRAST_DISABLED)
			{
				uniflatMobileThemeColors.colorAltContrastDisabled = colorChangeVO.color;
			}


			else if (colorChangeVO.ID == UniflatColorTarget.MISC_BACKGROUND)
			{
				uniflatMobileThemeColors.colorBackground = colorChangeVO.color;
			}
			else if (colorChangeVO.ID == UniflatColorTarget.MISC_STAGE)
			{
				uniflatMobileThemeColors.colorStage = colorChangeVO.color;
			}
			else if (colorChangeVO.ID == UniflatColorTarget.MISC_CONTRAST)
			{
				uniflatMobileThemeColors.colorContrast = colorChangeVO.color;
			}
			else if (colorChangeVO.ID == UniflatColorTarget.MISC_CONSTRAST_DISABLED)
			{
				uniflatMobileThemeColors.colorContrastDisabled = colorChangeVO.color;
			}


			changeThemeColors(uniflatMobileThemeColors);
		}


		private function onChangeColor(event : Event) : void
		{
			if (event.data) // when event.data is not null, a user-triggered color change has occurred
			{
				colorChangeVO = event.data as ColorChangeVO;
				applyColorTimer.reset();
				applyColorTimer.start();
			}
		}


		private function onCompleteTimerChangeColor(event : TimerEvent) : void
		{
			trace("onCompleteTimerChangeColor");
			applyColors();
		}


		private function onScreenSwitch(event : Event) : void
		{
			mNavigator.pushScreen(event.data.screen);
			Starling.juggler.delayCall(mDrawers.toggleLeftDrawer,
			                           0.25);
		}
	}
}
