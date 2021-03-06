package
{

	import com.marpies.demo.display.MenuList;
	import com.marpies.demo.enums.UniflatColorTarget;
	import com.marpies.demo.events.ColorChangeVO;
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

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;


	public class Main extends Sprite
	{

		private var mMenu : MenuList;
		private var mDrawers : Drawers;
		private var mNavigator : StackScreenNavigator;
		private var mNavigatorColorization : StackScreenNavigator;

		private var theme : BaseUniflatMobileTheme;
		private var tempEmptryScreen : StackScreenNavigatorItem         = new StackScreenNavigatorItem(EmptyScreen);
		private var uniflatMobileThemeColors : UniflatMobileThemeColors = new UniflatMobileThemeColors();


		public function Main()
		{
			super();
		}


		private function initTheme() : void
		{
			changeThemeColors(UniflatMobileThemeColors.Builder
			                                          .setColorStage(0x000000)
			                                          .setColorBackground(0x000000)
			                                          .setColorPrimary(0x00698C)
			                                          .setColorPrimaryDisabled(0xB4ECEA)
			                                          .setColorPrimaryContrast(0xFFFFFF)
			                                          .setColorPrimaryContrastDisabled(0xFFFFFF)
			                                          .setColorAlt(0xFF2D55)
			                                          .setColorAltDisabled(0xFFC0CC)
			                                          .setColorAltContrast(0xFFFFFF)
			                                          .setColorAltContrastDisabled(0xFFFFFF)
			                                          .setColorContrast(0x2B333A)
			                                          .setColorContrastDisabled(0xB1B4B7)
			                                          .build());
		}


		public function changeThemeColors(value : UniflatMobileThemeColors) : void
		{
			uniflatMobileThemeColors = value;

			if (theme)
			{
				theme.dispose();
			}

			theme = new UniflatMobileThemeWithIcons(value);


			if (mNavigator)
			{
				mNavigator.resetStyleProvider();

				resetCurrentScreen();
			}


			if (mMenu)
			{
				mMenu.resetStyleProvider();
			}

			if (mDrawers)
			{
				mDrawers.resetStyleProvider();
			}
		}


		/**
		 * This will inject a temporary empty screen, then revert back to the previous screen and finally remove the temporary screen.
		 * There can be better solutions available like e.g. some kind of invalidation which I am unaware of at this point in time
		 */
		private function resetCurrentScreen() : void
		{
			var lastScreen : String = mNavigator.activeScreenID;

			mNavigator.addScreen(Screens.EMPTY,
			                     tempEmptryScreen);

			mNavigator.pushScreen(Screens.EMPTY);
			mNavigator.pushScreen(lastScreen);
			mNavigator.removeScreen(Screens.EMPTY);
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


			mNavigatorColorization = new StackScreenNavigator();

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

			var button1LayoutData : HorizontalLayoutData = new HorizontalLayoutData();
			button1LayoutData.percentWidth               = 50;
			mDrawers.layoutData                          = button1LayoutData;

			var button2LayoutData : HorizontalLayoutData = new HorizontalLayoutData();
			button2LayoutData.percentWidth               = 50;
			mNavigatorColorization.layoutData            = button2LayoutData;

			layoutGroup.addChild(mDrawers);
			layoutGroup.addChild(mNavigatorColorization);
		}


		private function onChangeColor(event : Event) : void
		{
			if (event.data) // when event.data is not null, a user-triggered color change has occurred
			{
				var colorChangeVO : ColorChangeVO = event.data as ColorChangeVO;


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
				else if (colorChangeVO.ID == UniflatColorTarget.MISC_CONSTRAST)
				{
					uniflatMobileThemeColors.colorContrast = colorChangeVO.color;
				}
				else if (colorChangeVO.ID == UniflatColorTarget.MISC_CONSTRAST_DISABLED)
				{
					uniflatMobileThemeColors.colorContrastDisabled = colorChangeVO.color;
				}


				changeThemeColors(uniflatMobileThemeColors);
			}
		}


		private function onScreenSwitch(event : Event) : void
		{
			mNavigator.pushScreen(event.data.screen);
			Starling.juggler.delayCall(mDrawers.toggleLeftDrawer,
			                           0.25);
		}
	}
}
