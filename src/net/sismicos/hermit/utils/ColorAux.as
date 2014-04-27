package net.sismicos.hermit.utils 
{
	import net.sismicos.hermit.polar.PolarTileType;
	public class ColorAux 
	{
		public static const NORMAL_COLOR:uint     = 0xFF3CA0D0;
		public static const DANGER_COLOR:uint     = 0xFFFF4040;
		public static const CHECKPOINT_COLOR:uint = 0xFF39E639;
		public static const GOAL_COLOR:uint       = 0x00FFFFFF;
		
		public static const PLAYER_COLOR:uint     = 0xFFFFA640;
		
		public static const BACKGROUND_COLOR:uint = 0xFF505050;
		
		public static const FADEFLASH_COLOR:uint  = 0xFF505050;
		public static const FADEFLASH_DURATION:Number = 0.75;
		
		public static const TEXT_COLOR:uint        = 0xFFE0E0E0;
		public static const TEXT_SHADOW_COLOR:uint = NORMAL_COLOR;
		
		public static function GetTileColor(type:PolarTileType):uint
		{
			switch (type)
			{
				case PolarTileType.CHECKPOINT:
					return CHECKPOINT_COLOR;
				
				case PolarTileType.DANGEROUS:
					return DANGER_COLOR;
					
				case PolarTileType.GOAL:
					return GOAL_COLOR;
					
				case PolarTileType.NORMAL:
				default:
					return NORMAL_COLOR;
			}
		}
	}

}