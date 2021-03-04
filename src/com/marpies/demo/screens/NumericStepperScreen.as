package com.marpies.demo.screens
{

	import feathers.controls.NumericStepper;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;


	public class NumericStepperScreen extends BaseScreen
	{

		public function NumericStepperScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title = "NUMERIC STEPPER";

			layout = new AnchorLayout();

			const stepper : NumericStepper           = new NumericStepper();
			stepper.minimum                          = 0;
			stepper.maximum                          = 100;
			stepper.value                            = 37;
			stepper.step                             = 1;
			var stepperLayoutData : AnchorLayoutData = new AnchorLayoutData();
			stepperLayoutData.horizontalCenter       = 0;
			stepperLayoutData.verticalCenter         = -30;
			stepper.layoutData                       = stepperLayoutData;
			addChild(stepper);
			const stepper2 : NumericStepper           = new NumericStepper();
			stepper2.minimum                          = 0;
			stepper2.maximum                          = 100;
			stepper2.value                            = 37;
			stepper2.step                             = 1;
			stepper2.isEnabled                        = false;
			var stepper2LayoutData : AnchorLayoutData = new AnchorLayoutData();
			stepper2LayoutData.horizontalCenter       = 0;
			stepper2LayoutData.verticalCenter         = 30;
			stepper2.layoutData                       = stepper2LayoutData;
			addChild(stepper2);
		}

	}

}
