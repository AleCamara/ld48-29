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
			"los sistemas están formados por capas\nuna vez que entiendes una capa, puedes ir a por la siguiente",
			"entender una capa es un proceso educativo; muy reconfortante ...",
			"... y a veces doloroso y frustrante",
			"afortunadamente, no todas las cosas que aprendes se olvidan fácilmente",
			"el sistema que tengo bajo los pies es uno de los más complejos que jamás he conocido",
			"llevo años estudiando sistemas y sin embargo ¡este todavía consigue sorprenderme a menudo!",
			"hay algo aquí que me ATRAE fuertemente; no me deja escapar",
			"esta obsesión puede ser peligrosa, incluso fatal, pero nada puedo hacer",
			"no es sobre cómo es ELLA; es más bien sobre cómo soy you cuando estoy a su lado",
			"" ];
			
		
		private static const tutorials:Array = [
			"TUTORIAL: mueve a nuestro intrépido amigo con los cursores derecha e izquierda",
			"TUTORIAL: salta usando el cursor arriba; doble salto pulsando arriba en medio del aire",
			"TUTORIAL: evita las losas rojas si te preocupa nuestro pequeño colega",
			"TUTORIAL: las zonas verdes son majas; recuerdan tu posición en caso de que falles algún salto",
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