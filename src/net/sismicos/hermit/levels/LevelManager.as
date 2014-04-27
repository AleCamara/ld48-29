package net.sismicos.hermit.levels 
{
	import net.sismicos.hermit.levels.LevelDescription;
	
	public final class LevelManager 
	{
		[Embed(source = "../../../../../levels/dummy.png")] private static const LVL_DUMMY:Class;
		[Embed(source = "../../../../../levels/dummy2.png")] private static const LVL_DUMMY2:Class;
		
		private static const levels:Array = [
			LVL_DUMMY,
			LVL_DUMMY2,
			LVL_DUMMY,
			LVL_DUMMY ];
		private static var nextLevel:uint = 0;
		
		public static function GetNextLevel():LevelDescription
		{
			if (nextLevel >= levels.length)
			{
				return new LevelDescription(null);
			}
			
			return new LevelDescription(levels[nextLevel++]);
		}
	}

}