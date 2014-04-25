package net.sismicos.hermit.gamestates 
{
	import org.flixel.FlxState;
	
	public class DefaultState extends FlxState
	{
		public function DefaultState() 
		{
		}
		
		override public function create(): void
		{
			FlxState:create();
		}
	}

}