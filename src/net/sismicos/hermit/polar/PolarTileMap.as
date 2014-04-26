package net.sismicos.hermit.polar 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.flixel.FlxGroup;
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import net.sismicos.hermit.polar.PolarRect;
	
	public class PolarTileMap extends FlxObject
	{
		private var tiles:Array;
		private var isDirty:Boolean = true;
		private var buffers:Array;
		
		public function PolarTileMap() 
		{
			tiles = new Array();
			buffers = new Array();
		}
		
		public function LoadMap(image:Class):void
		{
			var tempBM:BitmapData = FlxG.addBitmap(image);
			if (!PolarAux.IsBitmapALevel(tempBM))
				throw new Error("Trying to load a bitmap that does not represent a level.");
			
			for (var i:uint = 0; i < tempBM.height; ++i)
			{
				for (var j:uint = 0; j < tempBM.width; ++j)
				{
					var r:uint = tempBM.height - i - 1;
					var p:uint = j;
					
					if (tempBM.getPixel(j, i) != 0xFFFFFF)
					{
						AddTile(r, p, new PolarTile(r, p));
					}
				}
			}
		}
		
		public function AddTile(r:uint, p:uint, tile:PolarTile):void
		{
			tiles.push(tile);
		}
		
		override public function draw():void
		{
			super.draw();
			
			if (isDirty) UpdateBuffers();
			
			for (var c:int; c < cameras.length; ++c)
			{
				cameras[c].buffer.copyPixels(buffers[c], buffers[c].rect, new Point(0, 0));
			}
		}
		
		override public function overlaps(object:FlxBasic, inScreenSpace:Boolean = false, camera:FlxCamera = null):Boolean
		{
			var result:Boolean = false;
			if (object is PolarSprite)
			{
				var sprite:PolarSprite = object as PolarSprite;
				var spRect:PolarRect = sprite.GetPolarRect();
					
				for (var i:uint = 0; i < tiles.length; ++i)
				{
					var tile:PolarTile = tiles[i] as PolarTile;
					var tileRect:PolarRect = tile.GetPolarRect();
					
					if ((null != tile.collideCallback) && tileRect.Overlaps(spRect))
					{
						tile.collideCallback(tile, object);
						result = true;
					}
				}
			}
			
			return result;
		}
		
		private function UpdateBuffers():void
		{
			if (!visible) return;
			
			if (!cameras) cameras = FlxG.cameras;
			for (var c:int = 0; c < cameras.length; ++c)
			{
				if (!buffers[c]) buffers[c] = new BitmapData(FlxG.width, FlxG.height, true, 0x444444);
				
				var buffer:BitmapData = buffers[c];
				for (var i:int = 0; i < tiles.length; ++i)
				{
					if (tiles[i]) buffer.draw(tiles[i].s);
				}
			}
			
			isDirty = false;
		}
	}

}