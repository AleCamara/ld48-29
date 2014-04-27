package net.sismicos.hermit.levels 
{
	import net.sismicos.hermit.levels.LevelDescription;
	
	public final class LevelManager 
	{
		[Embed(source = "../../../../../levels/dummy.png")] private static const LVL_DUMMY:Class;
		[Embed(source = "../../../../../levels/dummy2.png")] private static const LVL_DUMMY2:Class;
		
		[Embed(source = "../../../../../levels/level_01.png")] private static const LVL_01:Class;
		[Embed(source = "../../../../../levels/level_02.png")] private static const LVL_02:Class;
		[Embed(source = "../../../../../levels/level_03.png")] private static const LVL_03:Class;
		[Embed(source = "../../../../../levels/level_04.png")] private static const LVL_04:Class;
		[Embed(source = "../../../../../levels/level_05.png")] private static const LVL_05:Class;
		
		private static const levels:Array = [
			LVL_01,
			LVL_02,
			LVL_03,
			LVL_04,
			LVL_05 ];
			
		private static const texts:Array = [
			"systems are made of layers\nonce you understand a layer, you can proceed to the next one",
			"some layers require a bit of effor to understand",
			"understanding some layers can be a painful process",
			"but the things you've learnt are not easily forgotten",
			"there are convoluted layers that in reality are just plain boring",
			"THE END" ];
		
//			"a system can look trivial at first sight"
//			"but some times it's just appearances",
//			"something beautiful might be hidden\n\n\t\tBENEATH THE SURFACE",
		
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