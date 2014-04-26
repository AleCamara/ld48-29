package net.sismicos.hermit.utils 
{
	import net.sismicos.hermit.polar.PolarTileType;
	public class ColorAux 
	{
		public static const NORMAL_COLORS:Array = [
			0xFF67E667, 0xFF67E667, 0xFF67E667,
			0xFF67E667, 0xFF67E667, 0xFF67E667,
			0xFF00CC00, 0xFF39E639, 0xFF67E667,
			0xFFFF0000, 0xFFFF4040, 0xFFFF7373 ];
		
		public static const DANGER_COLORS:Array = [
			0xFFFF7373, 0xFFFF7373, 0xFFFF7373,
			0xFF67E667, 0xFF67E667, 0xFF67E667,
			0xFF00CC00, 0xFF39E639, 0xFF67E667,
			0xFFFF9400, 0xFFFFAE40, 0xFFFFC473,
			0xFF0B5FA5, 0xFF3F8FD2, 0xFF66A1D1 ];
		
		public static const GOAL_COLORS:Array = [
			0x0067E667, 0xFF67E667, 0xFF67E667,
			0xFF00CC00, 0xFF39E639, 0xFF67E667,
			0xFFFF0000, 0xFFFF4040, 0xFFFF7373,
			0xFFFF9400, 0xFFFFAE40, 0xFFFFC473,
			0xFF0B5FA5, 0xFF3F8FD2, 0xFF66A1D1 ];
			
		public static function GetTileColor(type:PolarTileType):uint
		{
			switch (type)
			{
				case PolarTileType.DANGEROUS:
					return DANGER_COLORS[0];
					
				case PolarTileType.GOAL:
					return GOAL_COLORS[0];
					
				case PolarTileType.NORMAL:
				default:
					return NORMAL_COLORS[0];
			}
		}
		
	}

}