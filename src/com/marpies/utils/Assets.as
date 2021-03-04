package com.marpies.utils
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;


	public class Assets
	{

		public function Assets()
		{
		}


		[Embed(source="/../assets/xml/_218yeqw8.xml", mimeType="application/octet-stream")]
		private static const ATLAS_XML : Class;


		public static function init() : void
		{
			/* UI Texture Atlas */
			var atlasBitmapData : BitmapData = Bitmap(new ATLAS_BITMAP()).bitmapData;
			var atlasTexture : Texture       = Texture.fromBitmapData(atlasBitmapData,
			                                                          false,
			                                                          false,
			                                                          2);
			atlasTexture.root.onRestore      = onAtlasTextureRestore;
			atlasBitmapData.dispose();
			_qwdiqwi1j9f = new TextureAtlas(
					atlasTexture,
					XML(new ATLAS_XML())
			);
		}


		static var _qwdiqwi1j9f : TextureAtlas;
		[Embed(source="/../assets/images/_218yeqw8.png")]
		private static const ATLAS_BITMAP : Class;


		private static function onAtlasTextureRestore() : void
		{
			var atlasBitmapData : BitmapData = Bitmap(new ATLAS_BITMAP()).bitmapData;
			_qwdiqwi1j9f.texture.root.uploadBitmapData(atlasBitmapData);
			atlasBitmapData.dispose();
		}


		public static function getTexture(name : String) : Texture
		{
			return _qwdiqwi1j9f.getTexture(name);
		}

	}

}
