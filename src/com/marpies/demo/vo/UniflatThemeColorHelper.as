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
//	DATE  		: 2021-03-07
//	DESCRIPTION	: 
//
//############################################################################


package com.marpies.demo.vo
{
	import feathers.themes.UniflatMobileThemeColors;


	public class UniflatThemeColorHelper
	{
		public static var COLOR_STAGE : uint             = 0xEEF2F6;
		public static var COLOR_BACKGROUND : uint        = 0xFFFFFF;
		public static var COLOR_CONTRAST : uint          = 0x2B333A;
		public static var COLOR_CONTRAST_DISABLED : uint = 0xB1B4B7;

		public static var COLOR_PRIMARY : uint                   = 0x07C1BB;
		public static var COLOR_PRIMARY_DISABLED : uint          = 0xB4ECEA;
		public static var COLOR_PRIMARY_CONTRAST : uint          = 0xFFFFFF;
		public static var COLOR_PRIMARY_CONTRAST_DISABLED : uint = 0xFFFFFF;

		public static var COLOR_ALTERNATIVE : uint                   = 0xFF2D55;
		public static var COLOR_ALTERNATIVE_DISABLED : uint          = 0xFFC0CC;
		public static var COLOR_ALTERNATIVE_CONTRAST : uint          = 0xFFFFFF;
		public static var COLOR_ALTERNATIVE_CONTRAST_DISABLED : uint = 0xFFFFFF;


		public function UniflatThemeColorHelper()
		{
		}


		public function fromJSON(value : String) : UniflatThemeColorHelper
		{
			try
			{
				var obj : Object = JSON.parse(value);


				if (obj)
				{
					if (obj.colorMiscStage)
					{
						COLOR_STAGE = getHexColor(obj.colorMiscStage);
					}

					if (obj.colorMiscBackground)
					{
						COLOR_BACKGROUND = getHexColor(obj.colorMiscBackground);
					}

					if (obj.colorMiscContrast)
					{
						COLOR_CONTRAST = getHexColor(obj.colorMiscContrast);
					}

					if (obj.colorMiscContrastDisabled)
					{
						COLOR_CONTRAST_DISABLED = getHexColor(obj.colorMiscContrastDisabled);
					}


					if (obj.colorPrimary)
					{
						COLOR_PRIMARY = getHexColor(obj.colorPrimary);
					}

					if (obj.colorPrimaryDisabled)
					{
						COLOR_PRIMARY_DISABLED = getHexColor(obj.colorPrimaryDisabled);
					}

					if (obj.colorPrimaryContrast)
					{
						COLOR_PRIMARY_CONTRAST = getHexColor(obj.colorPrimaryContrast);
					}

					if (obj.colorPrimaryContrastDisabled)
					{
						COLOR_PRIMARY_CONTRAST_DISABLED = getHexColor(obj.colorPrimaryContrastDisabled);
					}


					if (obj.colorAlternative)
					{
						COLOR_ALTERNATIVE = getHexColor(obj.colorAlternative);
					}

					if (obj.colorAlternativeDisabled)
					{
						COLOR_ALTERNATIVE_DISABLED = getHexColor(obj.colorAlternativeDisabled);
					}

					if (obj.colorAlternativeContrast)
					{
						COLOR_ALTERNATIVE_CONTRAST = getHexColor(obj.colorAlternativeContrast);
					}

					if (obj.colorAlternativeContrastDisabled)
					{
						COLOR_ALTERNATIVE_CONTRAST_DISABLED = getHexColor(obj.colorAlternativeContrastDisabled);
					}
				}
			}
			catch (error : Error)
			{
				return null;
			}

			return this;
		}


		public function toJSON() : String
		{
			var obj : Object = {

				"colorMiscStage":                   toHTMLColor(COLOR_STAGE),
				"colorMiscBackground":              toHTMLColor(COLOR_BACKGROUND),
				"colorMiscContrast":                toHTMLColor(COLOR_CONTRAST),
				"colorMiscContrastDisabled":        toHTMLColor(COLOR_CONTRAST_DISABLED),
				"colorPrimary":                     toHTMLColor(COLOR_PRIMARY),
				"colorPrimaryDisabled":             toHTMLColor(COLOR_PRIMARY_DISABLED),
				"colorPrimaryContrast":             toHTMLColor(COLOR_PRIMARY_CONTRAST),
				"colorPrimaryContrastDisabled":     toHTMLColor(COLOR_PRIMARY_CONTRAST_DISABLED),
				"colorAlternative":                 toHTMLColor(COLOR_ALTERNATIVE),
				"colorAlternativeDisabled":         toHTMLColor(COLOR_ALTERNATIVE_DISABLED),
				"colorAlternativeContrast":         toHTMLColor(COLOR_ALTERNATIVE_CONTRAST),
				"colorAlternativeContrastDisabled": toHTMLColor(COLOR_ALTERNATIVE_CONTRAST_DISABLED)
			};

			return JSON.stringify(obj,
			                      null,
			                      4);
		}


		public function toJSONFromUniflatMobileThemeColors(uniflatMobileThemeColors : UniflatMobileThemeColors) : String
		{
			var obj : Object = {

				"colorMiscStage":            toHTMLColor(uniflatMobileThemeColors.colorStage),
				"colorMiscBackground":       toHTMLColor(uniflatMobileThemeColors.colorBackground),
				"colorMiscContrast":         toHTMLColor(uniflatMobileThemeColors.colorContrast),
				"colorMiscContrastDisabled": toHTMLColor(uniflatMobileThemeColors.colorContrastDisabled),

				"colorPrimary":                 toHTMLColor(uniflatMobileThemeColors.colorPrimary),
				"colorPrimaryDisabled":         toHTMLColor(uniflatMobileThemeColors.colorPrimaryDisabled),
				"colorPrimaryContrast":         toHTMLColor(uniflatMobileThemeColors.colorPrimaryContrast),
				"colorPrimaryContrastDisabled": toHTMLColor(uniflatMobileThemeColors.colorPrimaryContrastDisabled),

				"colorAlternative":                 toHTMLColor(uniflatMobileThemeColors.colorAlt),
				"colorAlternativeDisabled":         toHTMLColor(uniflatMobileThemeColors.colorAltDisabled),
				"colorAlternativeContrast":         toHTMLColor(uniflatMobileThemeColors.colorAltContrast),
				"colorAlternativeContrastDisabled": toHTMLColor(uniflatMobileThemeColors.colorAltContrastDisabled)
			};

			return JSON.stringify(obj,
			                      null,
			                      4);
		}


		public function toUniflatMobileThemeColorsClassString(uniflatMobileThemeColors : UniflatMobileThemeColors) : String
		{
			var str : String = "var colors : UniflatMobileThemeColors = UniflatMobileThemeColors.Builder";


			str += ".setColorStage(" + uniflatMobileThemeColors.colorStage + ")";
			str += ".setColorBackground(" + uniflatMobileThemeColors.colorBackground + ")";
			str += ".setColorContrast(" + uniflatMobileThemeColors.colorContrast + ")";
			str += ".setColorContrastDisabled(" + uniflatMobileThemeColors.colorContrastDisabled + ")";

			str += ".setColorPrimary(" + uniflatMobileThemeColors.colorPrimary + ")";
			str += ".setColorPrimaryDisabled(" + uniflatMobileThemeColors.colorPrimaryDisabled + ")";
			str += ".setColorPrimaryContrast(" + uniflatMobileThemeColors.colorPrimaryContrast + ")";
			str += ".setColorPrimaryContrastDisabled(" + uniflatMobileThemeColors.colorPrimaryContrastDisabled + ")";

			str += ".setColorAlt(" + uniflatMobileThemeColors.colorAlt + ")";
			str += ".setColorAltDisabled(" + uniflatMobileThemeColors.colorAltDisabled + ")";
			str += ".setColorAltContrast(" + uniflatMobileThemeColors.colorAltContrast + ")";
			str += ".setColorAltContrastDisabled(" + uniflatMobileThemeColors.colorAltContrastDisabled + ")";

			str += ".build();";

			return str;
		}


		public function toUniflatMobileThemeColors() : UniflatMobileThemeColors
		{
			var uniflatMobileThemeColors : UniflatMobileThemeColors = new UniflatMobileThemeColors();

			uniflatMobileThemeColors.colorPrimary                 = COLOR_PRIMARY;
			uniflatMobileThemeColors.colorPrimaryDisabled         = COLOR_PRIMARY_DISABLED;
			uniflatMobileThemeColors.colorPrimaryContrast         = COLOR_PRIMARY_CONTRAST;
			uniflatMobileThemeColors.colorPrimaryContrastDisabled = COLOR_PRIMARY_CONTRAST_DISABLED;

			uniflatMobileThemeColors.colorAlt                 = COLOR_ALTERNATIVE;
			uniflatMobileThemeColors.colorAltDisabled         = COLOR_ALTERNATIVE_DISABLED;
			uniflatMobileThemeColors.colorAltContrast         = COLOR_ALTERNATIVE_CONTRAST;
			uniflatMobileThemeColors.colorAltContrastDisabled = COLOR_ALTERNATIVE_CONTRAST_DISABLED;

			uniflatMobileThemeColors.colorBackground       = COLOR_BACKGROUND;
			uniflatMobileThemeColors.colorStage            = COLOR_STAGE;
			uniflatMobileThemeColors.colorContrast         = COLOR_CONTRAST;
			uniflatMobileThemeColors.colorContrastDisabled = COLOR_CONTRAST_DISABLED;

			return uniflatMobileThemeColors;
		}


		private static function getHexColor(value : String) : uint
		{
			return parseInt(value.substr(1),
			                16);
		}


		private static function toHTMLColor(value : uint) : String
		{
			return "#" + value.toString(16);
		}
	}
}
