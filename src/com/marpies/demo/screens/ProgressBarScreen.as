package com.marpies.demo.screens
{

	import com.marpies.utils.HorizontalLayoutBuilder;

	import feathers.controls.ProgressBar;
	import feathers.layout.Direction;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;

	import starling.core.Starling;


	public class ProgressBarScreen extends BaseScreen
	{

		private var mHorizontalBarTween : uint;
		private var mVerticalBarTween : uint;


		public function ProgressBarScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title  = "PROGRESS BAR";
			layout = new HorizontalLayoutBuilder()
					.setGap(10)
					.setVerticalAlign(VerticalAlign.MIDDLE)
					.setHorizontalAlign(HorizontalAlign.CENTER)
					.build();

			/* Horizontal bar */
			const horizontalProgressBar : ProgressBar = getProgressBar(Direction.HORIZONTAL);
			addChild(horizontalProgressBar);

			/* Vertical bar */
			const verticalProgressBar : ProgressBar = getProgressBar(Direction.VERTICAL);
			addChild(verticalProgressBar);

			/* Tween the value */
			mHorizontalBarTween = Starling.juggler.tween(
					horizontalProgressBar,
					3.0,
					{value: 100, repeatCount: 0, reverse: true, repeatDelay: 1.5}
			);
			mVerticalBarTween   = Starling.juggler.tween(
					verticalProgressBar,
					3.0,
					{value: 100, repeatCount: 0, reverse: true, repeatDelay: 1.5}
			);
		}


		override public function dispose() : void
		{
			super.dispose();

			Starling.juggler.removeByID(mHorizontalBarTween);
			Starling.juggler.removeByID(mVerticalBarTween);
			mHorizontalBarTween = 0;
			mVerticalBarTween   = 0;
		}


		/**
		 *
		 *
		 * Helpers
		 *
		 *
		 */

		private function getProgressBar(direction : String) : ProgressBar
		{
			const pb : ProgressBar = new ProgressBar();
			pb.direction           = direction;
			pb.minimum             = 0;
			pb.maximum             = 100;
			pb.value               = 0;
			return pb;
		}

	}

}
