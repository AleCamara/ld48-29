package net.sismicos.hermit
{
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import net.sismicos.hermit.gamestates.TitleState;
	import net.sismicos.hermit.utils.ColorAux;
	
	[SWF(width="800", height="800", backgroundColor="#505050")]
	
	public class Main extends FlxGame 
	{
		public function Main()
		{
			super(800, 800, TitleState, 1);
			FlxG.bgColor = ColorAux.BACKGROUND_COLOR;
		}
	}
	
}