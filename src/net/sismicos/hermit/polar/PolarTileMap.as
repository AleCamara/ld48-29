package net.sismicos.hermit.polar 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import org.flixel.FlxObject;
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import net.sismicos.hermit.polar.PolarRect;
	import net.sismicos.hermit.polar.PolarTileMapLayer;
	import net.sismicos.hermit.levels.LevelManager;
	import net.sismicos.hermit.levels.LevelDescription;
	import org.flixel.FlxText;
	
	public class PolarTileMap extends FlxObject
	{
		private var tiles:Array;
		private var isDirty:Boolean = true;
		
		private var tileBuffer:BitmapData;
		
		private var camera:FlxCamera;
		
		private var layer:PolarTileMapLayer;
		
		private var level:LevelDescription;
		
		private var textLabel:FlxText;
		
		// ZOOMING
		private const ZOOM_TIME:Number = 2;
		private var zooming:Boolean = false;
		private var zoomingSpeed:Number;
		private var zoomingTime:Number;
		private var onZoomingEndCallback:Function = null;
		
		public function PolarTileMap(_layer:PolarTileMapLayer)
		{
			camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			camera.antialiasing = true;
			camera.bgColor = 0x00000000;
			FlxG.addCamera(camera);
			
			cameras = new Array();
			cameras[0] = camera;
			
			textLabel = new FlxText(10, 10, 300, "");
			textLabel.cameras = new Array();
			textLabel.cameras[0] = FlxG.cameras[0];
			textLabel.size = 10;
			textLabel.visible = false;
			
			SetLayer(_layer);
			
			tiles = new Array();
			
			LoadNextLevel();
			
			UpdateBuffer();
		}
		
		public function UpdateCameraRotation(rotation:Number):void
		{
			camera.angle = rotation;
		}
		
		public function BeginZooming():void
		{
			textLabel.visible = false;
			
			zooming = true;
			zoomingSpeed = (layer.nextZoom - layer.zoom) / ZOOM_TIME;
			zoomingTime = 0;
		}
		
		override public function draw():void
		{
			super.draw();
			if(textLabel.visible) textLabel.draw();
		}
		
		override public function update():void
		{
			super.update();
			
			if (zooming)
			{
				zoomingTime += FlxG.elapsed;
				camera.zoom += zoomingSpeed * FlxG.elapsed;
				if (zoomingTime > ZOOM_TIME)
				{
					OnZoomingEnded();
				}
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
		
		private function SetLayer(layer:PolarTileMapLayer):void
		{
			this.layer = layer;
			camera.zoom = layer.zoom;
			if (layer == PolarTileMapLayer.FIRST) textLabel.visible = true;
			else textLabel.visible = false;
		}
		
		private function AddTile(r:uint, p:uint, tile:PolarTile):void
		{
			tiles.push(tile);
		}
		private function ClearTiles():void
		{
			tiles.length = 0;
		}
		
		private function UpdateBuffer():void
		{
			camera.buffer.fillRect(camera.buffer.rect, 0x00000000);
			for (var i:int = 0; i < tiles.length; ++i)
			{
				if (tiles[i]) camera.buffer.draw(tiles[i].s);
			}
		}
		
		private function OnZoomingEnded():void
		{
			if (layer == PolarTileMapLayer.FIRST) LoadNextLevel();
			SetLayer(PolarTileMapLayer.GetNextLayer(layer));
			camera.zoom = layer.zoom;
			zooming = false;
		}
		
		private function LoadNextLevel():void
		{
			level = LevelManager.GetNextLevel();
			LoadMap();
		}
		
		private function LoadMap():void
		{
			ClearTiles();
			
			if (null != level.data)
			{
				var tempBM:BitmapData = FlxG.addBitmap(level.data);
				if (!PolarAux.IsBitmapALevel(tempBM))
					throw new Error("Trying to load a bitmap that does not represent a level.");
				
				for (var i:uint = 0; i < tempBM.height; ++i)
				{
					for (var j:uint = 0; j < tempBM.width; ++j)
					{
						var r:uint = tempBM.height - i - 1;
						var p:uint = j;
						
						var pixelColor:uint = tempBM.getPixel(j, i);
						if (pixelColor != 0xFFFFFF)
						{
							var tileType:PolarTileType;
							switch(pixelColor)
							{
								case 0x0000FF:
									tileType = PolarTileType.CHECKPOINT;
									break;
									
								case 0xFF0000:
									tileType = PolarTileType.DANGEROUS;
									break;
								case 0x00FF00:
									tileType = PolarTileType.GOAL;
									break;
								default:
									tileType = PolarTileType.NORMAL;
									break;
							}
							
							AddTile(r, p, new PolarTile(tileType, r, p));
						}
					}
				}
			}
			
			if (null != level.text)
			{
				textLabel.text = level.text;
			}
			
			UpdateBuffer();
		}
	}

}