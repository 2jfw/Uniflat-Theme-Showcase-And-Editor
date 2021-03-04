package com.marpies.demo.utils
{

	import starling.core.Starling;
	import starling.textures.Texture;


	public class Assets
	{

		[Embed(source="/../assets/feathers-logo.jpg")]
		private static const FEATHERS_LOGO : Class;

		private static var mFeathersLogoTexture : Texture;


		public static function get feathersLogoTexture() : Texture
		{
			if (!mFeathersLogoTexture)
			{
				mFeathersLogoTexture = Texture.fromBitmap(new FEATHERS_LOGO(),
				                                          false,
				                                          false,
				                                          Starling.contentScaleFactor);
			}
			return mFeathersLogoTexture;
		}

	}

}
