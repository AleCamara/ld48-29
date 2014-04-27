package net.sismicos.hermit.gamestates 
{
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import net.sismicos.hermit.Assets;
	import net.sismicos.hermit.FlickingEntity;
	import net.sismicos.hermit.utils.ColorAux;
	
	public class TitleState extends FlxState
	{
		private const PRESSENTER_FLICK_TIME:Number = 0.75;
		
		private var title:FlxSprite;
		private var pressEnter:FlickingEntity;
		
		override public function create():void
		{
			title = new FlxSprite(0, 0, Assets.PNG_TITLE);
			add(title);
			
			pressEnter = new FlickingEntity(PRESSENTER_FLICK_TIME, 192, 468, Assets.PNG_PRESSENTER);
			add(pressEnter);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justReleased("ENTER"))
			{
				FlxG.fade(ColorAux.FADEFLASH_COLOR, ColorAux.FADEFLASH_DURATION, LoadNextState);
			}
		}
		
		private function LoadNextState():void
		{
			FlxG.switchState(new IntroState());
		}
	}

}