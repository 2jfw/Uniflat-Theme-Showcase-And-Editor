package
{

	import com.marpies.utils.Assets;
	import com.marpies.utils.Constants;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.ContextMenu;

	import starling.core.Starling;
	import starling.events.Event;


	[SWF(width="700", height="800", frameRate="60", backgroundColor="#FFFFFF")]
	public class Startup extends Sprite
	{

		private var mStarling : Starling;


		public function Startup()
		{
			var menu : ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			contextMenu = menu;

			if (stage)
			{
				stage.align     = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}

			loaderInfo.addEventListener("complete",
			                            loaderInfo_completeHandler);
		}


		private function init() : void
		{
			mStarling = new Starling(Main,
			                         stage,
			                         new Rectangle(0,
			                                       0,
			                                       700,
			                                       800));
			mStarling.addEventListener(Event.ROOT_CREATED,
			                           onStarlingReady);
			mStarling.supportHighResolutions = true;
			mStarling.skipUnchangedFrames    = true;
			mStarling.stage.stageWidth       = 350;
			mStarling.stage.stageHeight      = 400;
			Constants.init(mStarling.stage.stageWidth,
			               mStarling.stage.stageHeight);
		}


		private function loaderInfo_completeHandler(event : *) : void
		{
			init();
		}


		/**
		 *
		 *
		 * Signal / Event handlers
		 *
		 *
		 */

		private function onStarlingReady(event : Event,
		                                 root : Main) : void
		{
			/* Start Starling */
			mStarling.start();
			Assets.init();
			root.start();
		}

	}

}
