package com.marpies.demo.screens
{

	import com.marpies.utils.VerticalLayoutBuilder;

	import feathers.controls.Label;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;


	public class LabelScreen extends BaseScreen
	{

		public function LabelScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title  = "LABELS";
			layout = new VerticalLayoutBuilder()
					.setGap(20)
					.setPadding(10)
					.setHorizontalAlign(HorizontalAlign.CENTER)
					.setVerticalAlign(VerticalAlign.MIDDLE)
					.build();
			styleNameList.add("j");

			const headingLabel : Label = new Label();
			headingLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			headingLabel.text = "Heading label";
			addChild(headingLabel);

			const normalLabel : Label = new Label();
			normalLabel.text          = "Normal label";
			addChild(normalLabel);

			const disabledLabel : Label = new Label();
			disabledLabel.text          = "Disabled label";
			disabledLabel.isEnabled     = false;
			addChild(disabledLabel);

			const detailLabel : Label = new Label();
			detailLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_DETAIL);
			detailLabel.text = "Detail label";
			addChild(detailLabel);
		}
	}

}
