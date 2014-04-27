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
			
		private static const texts:Array = [
			"This is a long text 0.",
			"This is a long text 1.",
			"This is a long text 2.",
			"This is a long text 3.",
			"THE END" ];
		
		
		private static var currentLevel:int = -1;
		
		public static function GetNextLevel():LevelDescription
		{
			if (currentLevel >= levels.length)
			{
				return new LevelDescription(null, levels[currentLevel]);
			}
			
			++currentLevel;
			return new LevelDescription(levels[currentLevel], texts[currentLevel]);
		}
	}

}