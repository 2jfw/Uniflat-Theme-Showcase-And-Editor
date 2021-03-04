package com.marpies.demo.screens
{

	import com.marpies.demo.utils.Assets;

	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.RelativePosition;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;


	public class AlertCalloutScreen extends BaseScreen
	{

		private var mTopLeftLayoutData : AnchorLayoutData;
		private var mTopRightLayoutData : AnchorLayoutData;
		private var mBottomRightLayoutData : AnchorLayoutData;
		private var mBottomLeftLayoutData : AnchorLayoutData;

		private var mFeathersImage : Image;


		public function AlertCalloutScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title = "ALERT & CALLOUT";

			layout = new AnchorLayout();
			styleNameList.add("j");

			/* Alert button */
			const alertButton : Button = new Button();
			alertButton.label          = "SHOW ALERT";
			alertButton.addEventListener(Event.TRIGGERED,
			                             onAlertButtonTriggered);
			var alertButtonLayoutData : AnchorLayoutData = new AnchorLayoutData();
			alertButtonLayoutData.horizontalCenter       = 0;
			alertButtonLayoutData.verticalCenter         = 0;
			alertButton.layoutData                       = alertButtonLayoutData;
			addChild(alertButton);

			/* Call out buttons */
			mTopLeftLayoutData     = new AnchorLayoutData();
			mTopRightLayoutData    = new AnchorLayoutData();
			mBottomRightLayoutData = new AnchorLayoutData();
			mBottomLeftLayoutData  = new AnchorLayoutData();

			const rightButton : Button = new Button();
			rightButton.label          = "RIGHT";
			rightButton.addEventListener(Event.TRIGGERED,
			                             onRightButtonTriggered);
			rightButton.layoutData = mTopLeftLayoutData;
			addChild(rightButton);

			const downButton : Button = new Button();
			downButton.label          = "DOWN";
			downButton.addEventListener(Event.TRIGGERED,
			                            onDownButtonTriggered);
			downButton.layoutData = mTopRightLayoutData;
			addChild(downButton);

			const upButton : Button = new Button();
			upButton.label          = "UP";
			upButton.addEventListener(Event.TRIGGERED,
			                          onUpButtonTriggered);
			upButton.layoutData = mBottomLeftLayoutData;
			addChild(upButton);

			const leftButton : Button = new Button();
			leftButton.label          = "LEFT";
			leftButton.addEventListener(Event.TRIGGERED,
			                            onLeftButtonTriggered);
			leftButton.layoutData = mBottomRightLayoutData;
			addChild(leftButton);
		}


		private function onAlertButtonTriggered() : void
		{
			Alert.show(
					"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
					"Why do we use it?",
					new ListCollection(
							[
								{label: "DISAGREE"},
								{label: "AGREE"}
							]
					)
			);
		}


		private function showCallout(origin : DisplayObject,
		                             direction : String) : void
		{
			Callout.show(feathersLogo,
			             origin).disposeContent = false;
		}


		private function onRightButtonTriggered(event : Event) : void
		{
			showCallout(event.currentTarget as DisplayObject,
			            RelativePosition.RIGHT);
		}


		private function onLeftButtonTriggered(event : Event) : void
		{
			showCallout(event.currentTarget as DisplayObject,
			            RelativePosition.LEFT);
		}


		private function onUpButtonTriggered(event : Event) : void
		{
			showCallout(event.currentTarget as DisplayObject,
			            RelativePosition.TOP);
		}


		private function onDownButtonTriggered(event : Event) : void
		{
			showCallout(event.currentTarget as DisplayObject,
			            RelativePosition.BOTTOM);
		}


		override protected function draw() : void
		{
			var layoutInvalid : Boolean = isInvalid(INVALIDATION_FLAG_LAYOUT);

			if (layoutInvalid)
			{
				mTopLeftLayoutData.top =
						mTopLeftLayoutData.left =
								mTopRightLayoutData.top =
										mTopRightLayoutData.right =
												mBottomLeftLayoutData.bottom =
														mBottomLeftLayoutData.left =
																mBottomRightLayoutData.bottom =
																		mBottomRightLayoutData.right = 10;
			}

			super.draw();
		}


		override public function dispose() : void
		{
			super.dispose();

			if (mFeathersImage)
			{
				mFeathersImage.dispose();
				mFeathersImage = null;
			}
		}


		/**
		 *
		 *
		 * Getters / Setters
		 *
		 *
		 */

		private function get feathersLogo() : Image
		{
			if (!mFeathersImage)
			{
				mFeathersImage = new Image(Assets.feathersLogoTexture);
			}
			return mFeathersImage;
		}

	}

}
