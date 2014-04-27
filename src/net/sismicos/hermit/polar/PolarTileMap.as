package net.sismicos.hermit.polar 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import org.flixel.FlxObject;
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import net.sismicos.hermit.polar.PolarRect;
	import net.sismicos.hermit.polar.PolarTileMapLayer;
	import net.sismicos.hermit.levels.LevelManager;
	import net.sismicos.hermit.levels.LevelDescription;
	import net.sismicos.hermit.utils.ColorAux;
	
	public class PolarTileMap extends FlxObject
	{
		private var tiles:Array;
		private var isDirty:Boolean = true;
		
		private var tileBuffer:BitmapData;
		
		private var camera:FlxCamera;
		
		private var layer:PolarTileMapLayer;
		
		private var level:LevelDescription;
		
		private var textLabel:FlxText;
		private var tutorialLabel:FlxText;
		
		// TRANSITION ZOOM
		private const ZOOM_TIME:Number = 2;
		
		// INITIAL ZOOM
		private const INITIALZOOM:Number = 0.1;
		private const INITIALZOOM_TIME:Number = 1;
		
		private var zoomingCallback:Function = null;
		private var zoomingCount:Number = 0;
		private var zoomingTime:Number = 0;
		private var zooming:Boolean = false;
		private var zoomingSpeed:Number;
		
		private const ENDGAME_TIME:Number = 2;
		private var endGameCount:Number = 0;
		private var endGameTimer:Boolean = false;
		private var endGameReady:Boolean = false;
		public var endGame:Boolean = false;
		
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
			textLabel.size = 14;
			textLabel.color = ColorAux.TEXT_COLOR;
			textLabel.shadow = ColorAux.TEXT_SHADOW_COLOR;
			textLabel.alignment = "center";
			textLabel.visible = false;
			
			tutorialLabel = new FlxText(150, 750, 500, "");
			tutorialLabel.cameras = new Array();
			tutorialLabel.cameras[0] = FlxG.cameras[0];
			tutorialLabel.size = 14;
			tutorialLabel.color = ColorAux.TEXT_COLOR;
			tutorialLabel.shadow = ColorAux.TEXT_SHADOW_COLOR;
			tutorialLabel.alignment = "center";
			tutorialLabel.visible = false;
			
			SetLayer(_layer);
			
			tiles = new Array();
			
			LoadNextLevel();
			
			UpdateBuffer();
			
			camera.zoom = INITIALZOOM;
			BeginZooming(INITIALZOOM, layer.zoom, INITIALZOOM_TIME, OnInitialZoomComplete);
		}
		
		public function UpdateCameraRotation(rotation:Number):void
		{
			camera.angle = rotation;
		}
		
		public function BeginTransition():void
		{
			textLabel.visible = false;
			tutorialLabel.visible = false;
			BeginZooming(layer.zoom, layer.nextZoom, ZOOM_TIME, OnTransitionComplete);
		}
		
		override public function draw():void
		{
			super.draw();
			if (textLabel.visible) textLabel.draw();
			if (tutorialLabel.visible) tutorialLabel.draw();
		}
		
		override public function update():void
		{
			super.update();
			
			if (zooming)
			{
				zoomingCount += FlxG.elapsed;
				camera.zoom += zoomingSpeed * FlxG.elapsed;
				if (zoomingCount > zoomingTime)
				{
					if (null != zoomingCallback) zoomingCallback();
					zooming = false;
				}
			}
			
			if (!endGame && endGameTimer)
			{
				endGameCount += FlxG.elapsed;
				if (endGameCount > ENDGAME_TIME)
				{
					endGame = true;
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
		
		private function BeginZooming(from:Number, to:Number, time:Number, callback:Function):void
		{
			zooming = true;
			zoomingSpeed = (to - from) / time;
			zoomingCount = 0;
			zoomingTime = time;
			zoomingCallback = callback;
		}
		
		private function SetLayer(layer:PolarTileMapLayer):void
		{
			this.layer = layer;
			camera.zoom = layer.zoom;
			if (layer == PolarTileMapLayer.FIRST)
			{
				if (endGameReady)
				{
					endGameTimer = true;
				}
				else
				{
					textLabel.visible = true;
					tutorialLabel.visible = true;
				}
			}
			else
			{
				textLabel.visible = false;
				tutorialLabel.visible = false;
			}
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
		
		private function OnTransitionComplete():void
		{
			if (layer == PolarTileMapLayer.FIRST) LoadNextLevel();
			SetLayer(PolarTileMapLayer.GetNextLayer(layer));
		}
		
		private function OnInitialZoomComplete():void
		{
			if (layer == PolarTileMapLayer.FIRST)
			{
				textLabel.visible = true;
				tutorialLabel.visible = true;
			}
		}
		
		private function LoadNextLevel():void
		{
			level = LevelManager.GetNextLevel();
			if (null != level) LoadMap();
			else
			{
				ClearTiles();
				UpdateBuffer();
			}
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
			else
			{
				endGameReady = true;
			}
			
			if (null != level.text)
			{
				textLabel.text = level.text;
			}
			if (null != level.tutorial)
			{
				tutorialLabel.text = level.tutorial;
			}
			
			UpdateBuffer();
		}
	}

}