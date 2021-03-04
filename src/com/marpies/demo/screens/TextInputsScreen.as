package com.marpies.demo.screens
{

	import com.marpies.utils.Assets;
	import com.marpies.utils.Constants;
	import com.marpies.utils.VerticalLayoutBuilder;

	import feathers.controls.AutoComplete;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	import feathers.data.LocalAutoCompleteSource;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;


	public class TextInputsScreen extends BaseScreen
	{

		private var mSendButton : Button;


		public function TextInputsScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title  = "TEXT INPUTS";
			layout = new VerticalLayoutBuilder()
					.setGap(10)
					.setPadding(10)
					.build();
			styleNameList.add("j");

			/* Header send button */
			mSendButton             = new Button();
			mSendButton.defaultIcon = new Image(Assets.getTexture("send-icon"));
			mSendButton.styleNameList.add("f");
			headerProperties.rightItems = new <DisplayObject>[
				mSendButton
			];

			/* Add inputs */
			addInputs();

			/* Add misc controls */
			addMiscControls();
		}


		private function addInputs() : void
		{
			const group : LayoutGroup = new LayoutGroup();
			group.layout              = new VerticalLayoutBuilder().setGap(10).build();
			group.layoutData          = new VerticalLayoutData(100);

			/* Recipient */
			group.addChild(getInputWithLabel("Recipient:"));

			/* Subject */
			group.addChild(getInputWithLabel("Subject:"));

			/* Message */
			group.addChild(getTextAreaWithLabel("Message:"));

			addChild(group);
		}


		private function addMiscControls() : void
		{
			const group : LayoutGroup                  = new LayoutGroup();
			group.layout                               = new VerticalLayoutBuilder().setGap(10).setHorizontalAlign(HorizontalAlign.LEFT).build();
			VerticalLayout(group.layout).paddingTop    = 10;
			VerticalLayout(group.layout).paddingBottom = 10;
			group.layoutData                           = new VerticalLayoutData(100);

			/* Attachments button */
			group.addChild(getButton("Add attachment...",
			                         Assets.getTexture("link-icon")));

			/* Address book button */
			group.addChild(getButton("Address book...",
			                         Assets.getTexture("people-icon")));

			/* Search address book input */
			const input : AutoComplete = new AutoComplete();
			input.styleNameList.add(TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT);
			input.prompt = "Address book - 'John', 'Jack'...";
			input.source = new LocalAutoCompleteSource(
					new ListCollection(
							new <String>
							[
								"John Doe",
								"Johnny Jackson",
								"Jack Jonson",
								"Kevin Johanssen",
								"John the Third"
							]
					)
			);
			group.addChild(input);

			addChild(group);
		}


		/**
		 *
		 *
		 * Helpers
		 *
		 *
		 */

		private function getTextAreaWithLabel(name : String) : LayoutGroup
		{
			const group : LayoutGroup = new LayoutGroup();
			group.layout              = new VerticalLayoutBuilder().setGap(5).build();
			group.layoutData          = new VerticalLayoutData(100);
			group.addChild(getLabel(name));
			const messageArea : TextArea = new TextArea();
			messageArea.height           = Constants.stageHeight >> 2;
			messageArea.layoutData       = new VerticalLayoutData(100);
			group.addChild(messageArea);
			return group;
		}


		private function getInputWithLabel(name : String) : LayoutGroup
		{
			const group : LayoutGroup = new LayoutGroup();
			group.layout              = new VerticalLayoutBuilder().build();
			group.layoutData          = new VerticalLayoutData(100);
			group.addChild(getLabel(name));
			const input : TextInput = new TextInput();
			input.layoutData        = new VerticalLayoutData(100);
			group.addChild(input);
			return group;
		}


		private function getButton(label : String,
		                           icon : Texture) : Button
		{
			const button : Button = new Button();
			button.label          = label;
			button.defaultIcon    = new Image(icon);
			return button;
		}


		private function getLabel(text : String) : Label
		{
			const label : Label = new Label();
			label.text          = text;
			label.paddingTop    = 10;
			label.styleNameList.add(Label.ALTERNATE_STYLE_NAME_DETAIL);
			return label;
		}

	}

}
