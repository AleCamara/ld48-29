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
		[Embed(source = "../../../../../levels/level_06.png")] private static const LVL_06:Class;
		[Embed(source = "../../../../../levels/level_07.png")] private static const LVL_07:Class;
		[Embed(source = "../../../../../levels/level_08.png")] private static const LVL_08:Class;
		[Embed(source = "../../../../../levels/level_09.png")] private static const LVL_09:Class;
		[Embed(source = "../../../../../levels/level_10.png")] private static const LVL_10:Class;
		
		private static const levels:Array = [
			LVL_01,
			LVL_02,
			LVL_03,
			//LVL_04,
			LVL_05,
			LVL_06,
			LVL_07,
			LVL_08,
			LVL_09,
			LVL_10 ];
			
		private static const texts:Array = [
			"systems are made of layers\nonce you understand a layer, you can proceed to the next one",
			"understanding a system is a learning process; very rewarding ...",
			"... and some times painful and frustrating",
			"thankfully not all the things you learn are easily forgotten",
			"this one i'm pointing at is the most complex system i've ever met",
			"i've been studying systems for years, yet this one still surprises me often!",
			"there's something here that strongly ATTRACTS me; like a moth to a flame",
			"this obsesion might be dangerous, even fatal, but i can't help it",
			"it's not how SHE is; it's more what i am when i'm close to HER",
			"" ];
			
		
		private static const tutorials:Array = [
			"TUTORIAL: move our intrepid friend with left and right cursors",
			"TUTORIAL: jump using cursor up; double jump pressing up again in mid-air",
			"TUTORIAL: avoid red zone if you care for this little fellah",
			"TUTORIAL: green zones are cool; they save your position in case you miss a jump",
			"",
			"",
			"",
			"",
			"",
			"" ];
		
		private static var currentLevel:int = -1;
		
		public static function GetNextLevel():LevelDescription
		{
			++currentLevel;
			
			if (currentLevel == levels.length)
			{
				return new LevelDescription(null, texts[currentLevel], tutorials[currentLevel]);
			}
			else if (currentLevel > levels.length)
			{
				return null;
			}
			return new LevelDescription(levels[currentLevel], texts[currentLevel], tutorials[currentLevel]);
		}
	}

}