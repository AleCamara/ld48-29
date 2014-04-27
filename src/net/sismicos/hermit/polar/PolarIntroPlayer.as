package net.sismicos.hermit.polar 
{
	import org.flixel.FlxG;
	import net.sismicos.hermit.polar.PolarPlayer;
	
	public class PolarIntroPlayer extends PolarPlayer
	{
		static private const FALLING_SPEED:Number = 100;
		
		public function PolarIntroPlayer() 
		{
			super(16, 0);
			
			UpdatePosition();
			x = -20;
			y = FlxG.height * 0.5;
		}
		
		override public function update():void
		{
			x -= FALLING_SPEED * FlxG.elapsed;
			
			if (x < -20)
			{
				x += FlxG.width + 40;
			}
		}
	}

}