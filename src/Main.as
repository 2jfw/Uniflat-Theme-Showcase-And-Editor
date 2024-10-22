package
{

	import com.marpies.demo.display.ExportThemeList;
	import com.marpies.demo.display.MenuList;
	import com.marpies.demo.enums.ThemeOptionsMenuAction;
	import com.marpies.demo.enums.UniflatColorTarget;
	import com.marpies.demo.events.OptionsEvent;
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
	import com.marpies.demo.screens.ThemeColorConfigurationScreen;
	import com.marpies.demo.screens.ToggleScreen;
	import com.marpies.demo.vo.ColorChangeVO;
	import com.marpies.demo.vo.UniflatThemeColorHelper;
	import com.marpies.utils.Constants;

	import feathers.controls.Alert;
	import feathers.controls.AutoSizeMode;
	import feathers.controls.Drawers;
	import feathers.controls.LayoutGroup;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.controls.TextCallout;
	import feathers.core.FeathersControl;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.RelativeDepth;
	import feathers.layout.VerticalAlign;
	import feathers.themes.BaseUniflatMobileTheme;
	import feathers.themes.UniflatMobileThemeColors;
	import feathers.themes.UniflatMobileThemeWithIcons;

	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.setTimeout;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;


	public class Main extends Sprite
	{

		[Embed(source="/../assets/json/Default.json", mimeType="application/octet-stream")]
		private static const DEFAULT_COLORS_JSON : Class;

		private var mMenu : MenuList;
		private var mMenuOptions : ExportThemeList;
		private var mDrawersComponents : Drawers;
		private var mDrawersColors : Drawers;
		private var mNavigator : StackScreenNavigator;
		private var mNavigatorColorization : StackScreenNavigator;

		private var theme : BaseUniflatMobileTheme;
		private var uniflatMobileThemeColors : UniflatMobileThemeColors = new UniflatMobileThemeColors();
		private var themeColors : UniflatThemeColorHelper               = new UniflatThemeColorHelper();
		private var applyColorTimer : Timer                             = new Timer(250,
		                                                                            1); // this timer prevents too frequent updates. Slightly hackish attempt..
		private var colorChangeVO : ColorChangeVO;
		private var fileRef : FileReference;
		private var textTypeFilter : FileFilter                         = new FileFilter("JSON Files (*.json)",
		                                                                                 "*.json;");


		public function Main()
		{
			super();

			Constants.uniflatMobileThemeColors = uniflatMobileThemeColors;
			Constants.themeColors              = themeColors;

			setupFileReference();

			applyColorTimer.addEventListener(TimerEvent.TIMER_COMPLETE,
			                                 onCompleteTimerChangeColor);
		}


		private function initTheme() : void
		{
			// Setting initial values seems to fix an issue where components would become white when changing colors


			// #1 this is how you would apply a theme copied as as3 class:
			//	var colors : UniflatMobileThemeColors = UniflatMobileThemeColors.Builder.setColorStage(16744098).setColorBackground(16449455).setColorContrast(15449341).setColorContrastDisabled(4456803).setColorPrimary(6352124).setColorPrimaryDisabled(16507645).setColorPrimaryContrast(16656427).setColorPrimaryContrastDisabled(157692).setColorAlt(3080794).setColorAltDisabled(14679791).setColorAltContrast(16284415).setColorAltContrastDisabled(38476).build();
			//	changeThemeColors(colors);


			// #2 this is the default style being applied from an embedded JSON file
			changeThemeColors(themeColors.fromJSON(new DEFAULT_COLORS_JSON()).toUniflatMobileThemeColors());
		}


		private function changeThemeColors(value : UniflatMobileThemeColors = null) : void
		{
			if (value)
			{
				Constants.uniflatMobileThemeColors = uniflatMobileThemeColors = value;
			}

			if (theme)
			{
				theme.dispose();
			}


			theme = new UniflatMobileThemeWithIcons(value);

			resetAllStyleProviders(this);
			resetThemeColorConfigurationScreen();
		}


		private function resetThemeColorConfigurationScreen() : void
		{
			if (mNavigatorColorization)
			{
				var screen : ThemeColorConfigurationScreen = mNavigatorColorization.getChildAt(0) as ThemeColorConfigurationScreen;

				screen.applyFromTheme(uniflatMobileThemeColors);
			}
		}


		private function resetAllStyleProviders(control : Sprite) : void
		{
			var len : int = control.numChildren;
			var childControl : FeathersControl;

			for (var i : int = 0; i < len; i++)
			{
				childControl = control.getChildAt(i) as FeathersControl;

				if (childControl)
				{
					if (childControl.numChildren > 0)
					{
						resetAllStyleProviders(childControl);
					}

					childControl.invalidate();
					childControl.resetStyleProvider();
				}
			}
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
			mDrawersComponents                           = new Drawers(mNavigator);
			mDrawersComponents.leftDrawer                = mMenu;
			mDrawersComponents.clipDrawers               = true;
			mDrawersComponents.openMode                  = RelativeDepth.ABOVE;
			mDrawersComponents.leftDrawerToggleEventType = ScreenEvent.TOGGLE_MENU;

			mDrawersComponents.layoutData = new HorizontalLayoutData(50,
			                                                         NaN);

			mMenuOptions = new ExportThemeList();
			mMenuOptions.addEventListener(OptionsEvent.CHANGE,
			                              onChangeOptions);

			mDrawersColors                            = new Drawers(mNavigatorColorization);
			mDrawersColors.rightDrawer                = mMenuOptions;
			mDrawersColors.clipDrawers                = true;
			mDrawersColors.openMode                   = RelativeDepth.ABOVE;
			mDrawersColors.rightDrawerToggleEventType = ScreenEvent.TOGGLE_MENU;

			mDrawersColors.layoutData = new HorizontalLayoutData(50,
			                                                     NaN);


			var layoutGroup : LayoutGroup = new LayoutGroup();
			layoutGroup.autoSizeMode      = AutoSizeMode.STAGE;
			var layout : HorizontalLayout = new HorizontalLayout();
			layout.horizontalAlign        = HorizontalAlign.CENTER;
			layout.verticalAlign          = VerticalAlign.MIDDLE;
			layout.gap                    = 10;

			layoutGroup.layout = layout;
			addChild(layoutGroup);

			layoutGroup.addChild(mDrawersComponents);
			layoutGroup.addChild(mDrawersColors);

			resetThemeColorConfigurationScreen();
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
			Starling.juggler.delayCall(mDrawersComponents.toggleLeftDrawer,
			                           0.25);
		}


		private function onChangeOptions(event : Event) : void
		{
			if (event.data) // when event.data is not null, a user-triggered color change has occurred
			{


				if (event.data.action == ThemeOptionsMenuAction.SAVE_JSON_CLIPBOARD)
				{
					Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,
					                                   Constants.themeColors.toJSONFromUniflatMobileThemeColors(Constants.uniflatMobileThemeColors));

					TextCallout.show("Theme copied to Clipboard as JSON",
					                 mNavigatorColorization,
					                 null,
					                 false);
				}
				if (event.data.action == ThemeOptionsMenuAction.SAVE_CLASS_CLIPBOARD)
				{
					Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,
					                                   Constants.themeColors.toUniflatMobileThemeColorsClassString(Constants.uniflatMobileThemeColors));

					TextCallout.show("Theme copied to Clipboard as Class",
					                 mNavigatorColorization,
					                 null,
					                 false);
				}
				else if (event.data.action == ThemeOptionsMenuAction.SAVE_JSON_DISK)
				{
					fileRef.addEventListener(flash.events.Event.COMPLETE,
					                         onCompleteSave);

					saveFile();
				}
				else if (event.data.action == ThemeOptionsMenuAction.LOAD_JSON_CLIPBOARD)
				{
					applyFromString(Clipboard.generalClipboard.getData(ClipboardFormats.TEXT_FORMAT) as String);
				}
				else if (event.data.action == ThemeOptionsMenuAction.LOAD_JSON_DISK)
				{
					fileRef.addEventListener(flash.events.Event.SELECT,
					                         onSelectFile);

					fileRef.browse([textTypeFilter]);
				}
				else if (event.data.action == ThemeOptionsMenuAction.RESET)
				{
					initTheme();

					TextCallout.show("Theme resetted to Default",
					                 mNavigatorColorization,
					                 null,
					                 false);
				}
			}
		}


		private function applyFromString(value : String) : void
		{
			try
			{
				var _themeColors : UniflatMobileThemeColors = themeColors.fromJSON(value).toUniflatMobileThemeColors();

				changeThemeColors(_themeColors);

				TextCallout.show("Theme applied successfully",
				                 mNavigatorColorization,
				                 null,
				                 false);
			}
			catch (error : Error)
			{
				var alert : Alert = Alert.show("Could not parse JSON!",
				                               "Error",
				                               null);


				setTimeout(function () : void {
					           alert.removeFromParent(true);
				           },
				           1500);
			}
		}


		////////////////////////////////////////////////
		// File operations
		////////////////////////////////////////////////


		private function setupFileReference() : void
		{
			fileRef = new FileReference();

			fileRef.addEventListener(flash.events.Event.CANCEL,
			                         onCancel);
		}


		private function onCancel(evt : flash.events.Event) : void
		{
			fileRef.removeEventListener(flash.events.Event.SELECT,
			                            onSelectFile);

			fileRef.removeEventListener(flash.events.Event.COMPLETE,
			                            onCompleteLoad);

			fileRef.removeEventListener(flash.events.Event.COMPLETE,
			                            onCompleteSave);
		}


		private function onCompleteLoad(evt : flash.events.Event) : void
		{
			fileRef.removeEventListener(flash.events.Event.COMPLETE,
			                            onCompleteLoad);

			var bytes : ByteArray = fileRef.data;
			var str : String      = bytes.readUTFBytes(bytes.length);

			applyFromString(str);
		}


		private function onSelectFile(evt : flash.events.Event) : void
		{
			fileRef.removeEventListener(flash.events.Event.SELECT,
			                            onSelectFile);

			fileRef.addEventListener(flash.events.Event.COMPLETE,
			                         onCompleteLoad);

			fileRef.load();
		}


		private function onCompleteSave(evt : flash.events.Event) : void
		{
			fileRef.removeEventListener(flash.events.Event.COMPLETE,
			                            onCompleteSave);

			TextCallout.show("Theme saved to Disk",
			                 mNavigatorColorization,
			                 null,
			                 false);
		}


		private function saveFile() : void
		{
			fileRef.save(Constants.themeColors.toJSONFromUniflatMobileThemeColors(Constants.uniflatMobileThemeColors),
			             "UniflatTheme.json");
		}
	}
}
