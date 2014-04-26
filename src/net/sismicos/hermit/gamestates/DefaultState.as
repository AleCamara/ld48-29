package net.sismicos.hermit.gamestates 
{
	import net.sismicos.hermit.polar.PolarTileMap;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import net.sismicos.hermit.polar.PolarTile;
	import net.sismicos.hermit.polar.PolarAux;
	import net.sismicos.hermit.Assets;
	
	public class DefaultState extends FlxState
	{
		private var tilemap:PolarTileMap;
		
		override public function create(): void
		{
			tilemap = new PolarTileMap()
			tilemap.LoadMap(Assets.LVL_DUMMY);
			
			add(tilemap);
		}
	}

}