package net.sismicos.hermit.gamestates 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import net.sismicos.hermit.polar.PolarPlayer;
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
	
	public class DefaultState extends FlxState
	{
		private var tilemaps:Array = null;
		private var player:PolarPlayer = null;
		
		private var activeTilemap:PolarTileMap;
		
		override public function create(): void
		{
			cameras = FlxG.cameras;
			cameras[0].bgColor = 0xFF444444;
			
			if (!tilemaps) tilemaps = new Array();
			tilemaps[0] = new PolarTileMap(0, ColorAux.GetTileColor(0, 0))
			tilemaps[0].LoadMap(Assets.LVL_DUMMY);
			tilemaps[1] = new PolarTileMap(0.4, ColorAux.GetTileColor(0, 1))
			tilemaps[1].LoadMap(Assets.LVL_DUMMY2);
			tilemaps[2] = new PolarTileMap(0.1, ColorAux.GetTileColor(0, 2))
			tilemaps[2].LoadMap(Assets.LVL_DUMMY);
			activeTilemap = tilemaps[0];
			
			add(tilemaps[2]);
			add(tilemaps[1]);
			add(tilemaps[0]);
			
			player = new PolarPlayer();
			add(player);
		}
		
		override public function update():void
		{
			super.update();
			
			activeTilemap.overlaps(player);
			
			UpdateCameras();
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