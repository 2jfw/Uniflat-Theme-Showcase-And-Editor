package com.marpies.demo.screens
{

	import com.marpies.utils.HorizontalLayoutBuilder;

	import feathers.controls.Slider;
	import feathers.layout.Direction;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;


	public class SliderScreen extends BaseScreen
	{

		public function SliderScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title  = "SLIDER";
			layout = new HorizontalLayoutBuilder()
					.setGap(10)
					.setVerticalAlign(VerticalAlign.MIDDLE)
					.setHorizontalAlign(HorizontalAlign.CENTER)
					.build();

			/* Horizontal slider */
			const horizontalSlider : Slider = new Slider();
			horizontalSlider.direction      = Direction.HORIZONTAL;
			horizontalSlider.minimum        = 0;
			horizontalSlider.maximum        = 100;
			horizontalSlider.value          = 40;
			horizontalSlider.width          = 160;
			addChild(horizontalSlider);

			/* Vertical slider */
			const verticalSlider : Slider = new Slider();
			verticalSlider.direction      = Direction.HORIZONTAL;
			verticalSlider.minimum        = 0;
			verticalSlider.maximum        = 100;
			verticalSlider.value          = 40;
			verticalSlider.height         = 160;
			addChild(verticalSlider);
		}

	}

}
