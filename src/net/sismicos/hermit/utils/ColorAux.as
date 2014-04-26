package net.sismicos.hermit.utils 
{
	public class ColorAux 
	{
		public static const colors:Array = [
			0xFF0000, 0xFF4040, 0xFF7373,
			0xFF9400, 0xFFAE40, 0xFFC473,
			0x0B5FA5, 0x3F8FD2, 0x66A1D1,
			0x00CC00, 0x39E639, 0x67E667 ];
		
		public static function GetTileColor(active:int = 0, stress:int = 0):uint
		{
			active %= 4;
			stress %= 3;
			const index:int = active * 3 + stress;
			return colors[index];
		}
		
	}

}