package net.sismicos.hermit.gamestates 
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import net.sismicos.hermit.utils.ColorAux;
	import net.sismicos.hermit.polar.PolarIntroPlayer;
	
	public class IntroState extends FlxState
	{
		private var player:PolarIntroPlayer;
		
		private var text:Array = [
			"i love complex systems",
			"a system can look trivial at first sight",
			"but some times it's just appearances",
			"something beautiful might be hidden",
			"BENEATH THE SURFACE" ];
		private var currentText:uint = 0;
		private var label:FlxText;
		
		private const TEXTSKIP_TIME:Number = 3;
		private var textSkipCount:Number = 0;
		
		private var readyForTransition:Boolean = false;
		private var dramaticPauseTime:Number = 0;
		private const DRAMATICPAUSE_TIME:Number = 2;
		
		override public function create():void
		{
			FlxG.flash(ColorAux.FADEFLASH_COLOR, ColorAux.FADEFLASH_DURATION, FlashFinished);
			
			cameras = FlxG.cameras;
			cameras[0].bgColor = ColorAux.BACKGROUND_COLOR;
			
			player = new PolarIntroPlayer();
			player.MakeUnmovable();
			add(player);
			
			label = new FlxText(100, 468, 600, "");
			label.cameras = new Array();
			label.cameras[0] = cameras[0];
			label.size = 24;
			label.alignment = "center";
			label.color = ColorAux.TEXT_COLOR;
			label.shadow = ColorAux.TEXT_SHADOW_COLOR;
			add(label);
		}
		
		override public function update():void
		{
			super.update();
			
			if (!readyForTransition)
			{
				textSkipCount += FlxG.elapsed;
				if ((textSkipCount > TEXTSKIP_TIME) || FlxG.keys.justReleased("ENTER"))
				{
					ShowNextText();
				}
			}
			else
			{
				dramaticPauseTime += FlxG.elapsed;
				if (dramaticPauseTime > DRAMATICPAUSE_TIME)
				{
					FlxG.fade(ColorAux.FADEFLASH_COLOR, ColorAux.FADEFLASH_DURATION, OnFadeComplete);
				}
			}
		}
		
		private function FlashFinished():void
		{
			ShowNextText();
		}
		
		private function ShowNextText():void
		{
			textSkipCount = 0;
			if (currentText < text.length)
			{
				label.text = text[currentText];
			}
			else
			{
				label.text = "";
				OnReadyForTransition();
			}
			++currentText;
		}
		
		private function OnReadyForTransition():void
		{
			readyForTransition = true;
		}
		
		private function OnFadeComplete():void
		{
			FlxG.switchState(new PlayState());
		}
	}

}