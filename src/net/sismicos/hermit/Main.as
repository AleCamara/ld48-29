package net.sismicos.hermit
{
	import org.flixel.FlxGame;
	
	import net.sismicos.hermit.gamestates.DefaultState;
	
	[SWF(width="800", height="800", backgroundColor="#444444")]
	
	public class Main extends FlxGame 
	{
		public function Main()
		{
			super(800, 800, DefaultState, 1);
		}
	}
	
}