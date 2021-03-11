package com.marpies.utils
{

	import feathers.themes.UniflatMobileThemeColors;

	import starling.core.Starling;


	public class Constants
	{

		private static var mScaleFactor : Number;
		private static var mStageWidth : int;
		private static var mStageHeight : int;

		public static const IPAD_WIDTH : int  = 512;
		public static const IPAD_HEIGHT : int = 384;

		public static var uniflatMobileThemeColors : UniflatMobileThemeColors;


		public static function init(stageWidth : int,
		                            stageHeight : int) : void
		{
			mStageWidth  = stageWidth;
			mStageHeight = stageHeight;
			mScaleFactor = Starling.contentScaleFactor;
		}


		public static function get stageWidth() : int
		{
			return mStageWidth;
		}


		public static function get stageHeight() : int
		{
			return mStageHeight;
		}


		public static function get scaleFactor() : int
		{
			return mScaleFactor;
		}

	}

}
