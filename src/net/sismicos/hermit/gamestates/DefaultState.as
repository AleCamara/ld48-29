package net.sismicos.hermit.gamestates 
{
	import net.sismicos.hermit.polar.PolarPlayer;
	import net.sismicos.hermit.polar.PolarTileMap;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxObject;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxRect;
	import net.sismicos.hermit.polar.PolarTile;
	import net.sismicos.hermit.polar.PolarAux;
	import net.sismicos.hermit.Assets;
	
	public class DefaultState extends FlxState
	{
		private var tilemap:PolarTileMap;
		private var player:PolarPlayer;
		
		public static function separate(o1:FlxObject, o2:FlxObject):Boolean
		{
			if ((o1 is PolarPlayer) && (o2 is PolarTile))
			{
				return separate(o2, o1);
			}
			if (!(o1 is PolarTile) && !(o2 is PolarPlayer))
			{
				return false;
			}
			
			var tile:PolarTile = o1 as PolarTile;
			var player:PolarPlayer = o2 as PolarPlayer;
			
			var tileRect:FlxRect = tile.GetPolarRect();
			var playerRect:FlxRect = player.GetPolarRect();
			
			return false;
		}
		
		override public function create(): void
		{
			if (!cameras)
			{
				cameras = FlxG.cameras;
				for (var i:uint = 0; i < cameras.length; ++i)
				{
					cameras[i].antialiasing = true;
				}
			}
			
			tilemap = new PolarTileMap()
			tilemap.LoadMap(Assets.LVL_DUMMY);
			
			player = new PolarPlayer();
			
			add(tilemap);
			add(player);
		}
		
		override public function update():void
		{
			super.update();
			
			if (player && cameras && (cameras.length > 0))
			{
				var playerPhi:Number = player.GetPhi() * (180.0 / Math.PI);
				for (var i:uint; i < cameras.length; ++i)
				{
					cameras[i].angle = playerPhi - 90;
				}
			}
			
			//FlxG.collide(tilemap, player);
		}
	}

}