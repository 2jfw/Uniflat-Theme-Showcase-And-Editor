package com.marpies.demo.screens
{

	import com.marpies.utils.Constants;
	import com.marpies.utils.HorizontalLayoutBuilder;

	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import feathers.layout.VerticalAlign;
	import feathers.media.FullScreenToggleButton;
	import feathers.media.MuteToggleButton;
	import feathers.media.PlayPauseToggleButton;
	import feathers.media.SeekSlider;
	import feathers.media.TimeLabel;
	import feathers.media.VideoPlayer;
	import feathers.media.VolumeSlider;

	import starling.events.Event;


	public class VideoPlayerScreen extends BaseScreen
	{

		private var mVideoPlayer : VideoPlayer;
		private var mVideoLoader : ImageLoader;
		private var mLoadingLabel : Label;


		public function VideoPlayerScreen()
		{
			super();
		}


		override protected function initialize() : void
		{
			super.initialize();

			title = "VIDEO PLAYER";

			layout = new AnchorLayout();
			styleNameList.add("j");

			mLoadingLabel            = new Label();
			mLoadingLabel.text       = "Loading video...";
			mLoadingLabel.layoutData = new AnchorLayoutData(NaN,
			                                                NaN,
			                                                NaN,
			                                                NaN,
			                                                0,
			                                                0);
			addChild(mLoadingLabel);

			mVideoPlayer             = new VideoPlayer();
			mVideoPlayer.layoutData  = new AnchorLayoutData(0,
			                                                0,
			                                                0,
			                                                0);
			mVideoPlayer.videoSource = "http://feathers.marpies.com/sample-video.mp4";
			mVideoPlayer.addEventListener(Event.READY,
			                              onVideoPlayerReady);
			addChild(mVideoPlayer);

			mVideoLoader = new ImageLoader();
			mVideoPlayer.addChild(mVideoLoader);
		}


		/**
		 *
		 *
		 * Private API
		 *
		 *
		 */

		private function onVideoPlayerReady() : void
		{
			mVideoPlayer.removeEventListener(Event.READY,
			                                 onVideoPlayerReady);

			removeChild(mLoadingLabel);
			mLoadingLabel = null;

			mVideoLoader.source = mVideoPlayer.texture;

			mVideoPlayer.x = (Constants.stageWidth - mVideoPlayer.width) >> 1;
			mVideoPlayer.y = (Constants.stageHeight - mVideoPlayer.height) >> 1;

			/* Controls */
			addControls();
		}


		private function addControls() : void
		{
			var controls : LayoutGroup = new LayoutGroup();
			controls.styleNameList.add(LayoutGroup.ALTERNATE_STYLE_NAME_TOOLBAR);
			mVideoPlayer.addChild(controls);

			var button : PlayPauseToggleButton = new PlayPauseToggleButton();
			controls.addChild(button);

			var slider : SeekSlider = new SeekSlider();
			controls.addChild(slider);

			var time : TimeLabel = new TimeLabel();
			controls.addChild(time);

			var mute : MuteToggleButton = new MuteToggleButton();
			controls.addChild(mute);

			var volume : VolumeSlider = new VolumeSlider();
			controls.addChild(volume);

			var fs : FullScreenToggleButton = new FullScreenToggleButton();
			controls.addChild(fs);

			var layout : HorizontalLayout = new HorizontalLayoutBuilder()
					.setGap(10)
					.setVerticalAlign(VerticalAlign.MIDDLE)
					.setHorizontalAlign(HorizontalAlign.CENTER)
					.build();
			controls.layout               = layout;

			var seekSliderLayoutData : HorizontalLayoutData   = new HorizontalLayoutData();
			seekSliderLayoutData.percentWidth                 = 70;
			slider.layoutData                                 = seekSliderLayoutData;
			var volumeSliderLayoutData : HorizontalLayoutData = new HorizontalLayoutData();
			volumeSliderLayoutData.percentWidth               = 20;
			volume.layoutData                                 = volumeSliderLayoutData;

			mVideoLoader.layoutData = new AnchorLayoutData(0,
			                                               0,
			                                               0,
			                                               0);

			controls.layoutData = new AnchorLayoutData(NaN,
			                                           20,
			                                           5,
			                                           20);
		}

	}

}
