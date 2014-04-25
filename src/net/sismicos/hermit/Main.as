package net.sismicos.hermit
{
	import org.flixel.FlxGame;
	
	import net.sismicos.hermit.gamestates.DefaultState;
	
	[SWF(width="640", height="360", backgroundColor="#444444")]
	
	public class Main extends FlxGame 
	{
		public function Main()
		{
			super(640, 360, DefaultState, 1);
		}
	}
	
}