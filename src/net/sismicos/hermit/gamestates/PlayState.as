package net.sismicos.hermit.gamestates 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import net.sismicos.hermit.polar.PolarPlayer;
	import net.sismicos.hermit.polar.PolarPoint;
	import net.sismicos.hermit.polar.PolarTileMap;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxObject;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxRect;
	import net.sismicos.hermit.polar.PolarTile;
	import net.sismicos.hermit.polar.PolarAux;
	import net.sismicos.hermit.Assets;
	import net.sismicos.hermit.utils.ColorAux;
	import net.sismicos.hermit.polar.PolarTileMapLayer;
	
	public class PlayState extends FlxState
	{
		private var tilemaps:Array = null;
		
		private const PLAYER_MOVE_FLASH_TIME:Number = 1.5;
		private var player:PolarPlayer = null;
		
		private var activeTilemap:uint = 0;
		
		private const WAITINGSTART_TIME:Number = 1;
		private var waitingStart:Boolean = true;
		private var waitingCount:Number = 0;
		
		override public function create(): void
		{
			cameras = FlxG.cameras;
			cameras[0].bgColor = ColorAux.BACKGROUND_COLOR;
			
			if (!tilemaps) tilemaps = new Array();
			tilemaps[0] = new PolarTileMap(PolarTileMapLayer.FIRST)
			tilemaps[1] = new PolarTileMap(PolarTileMapLayer.SECOND)
			tilemaps[2] = new PolarTileMap(PolarTileMapLayer.THIRD)
			tilemaps[0].textLabel.visible = false;
			add(tilemaps[2]);
			add(tilemaps[1]);
			add(tilemaps[0]);
			
			player = new PolarPlayer(18);
			add(player);
		}
		
		override public function update():void
		{
			super.update();
			
			if (waitingStart)
			{
				waitingCount >= FlxG.elapsed;
				if (waitingCount > WAITINGSTART_TIME)
				{
					waitingStart = false;
					(tilemaps[0] as PolarTileMap).textLabel.visible = true;
				}
			}
			
			(tilemaps[activeTilemap] as PolarTileMap).overlaps(player);
			
			// Check die condition
			if (player.HasDied())
			{
				(cameras[0] as FlxCamera).flash(0xFFFFFFFF, PLAYER_MOVE_FLASH_TIME);
				player.Undie();
			}
			if (player.HasWon())
			{
				(cameras[0] as FlxCamera).flash(0xFFFFFFFF, PLAYER_MOVE_FLASH_TIME);
				for (var i:uint = 0; i < tilemaps.length; ++i)
				{
					(tilemaps[i] as PolarTileMap).BeginTransition();
				}
				activeTilemap = (activeTilemap + 1) % tilemaps.length;
				player.Unwin();
				player.MoveToLastCheckpoint();
			}
			
			UpdateCameras();
		}
		
		private function OnZoomingFinished(object:PolarTileMap):void
		{
			
		}
		
		private function UpdateCameras():void
		{
			var playerPhi:Number = player.GetPhiInitial() * (180.0 / Math.PI);
			for (var i:uint; i < tilemaps.length; ++i)
			{
				tilemaps[i].UpdateCameraRotation(-playerPhi - 90);
			}
		}
	}

}