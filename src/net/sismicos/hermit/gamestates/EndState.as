package net.sismicos.hermit.gamestates 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import net.sismicos.hermit.polar.PolarEndPlayer;
	import net.sismicos.hermit.utils.ColorAux;
	import net.sismicos.hermit.Assets;
	
	public class EndState extends FlxState
	{
		private var player:PolarEndPlayer;
		private var heart:FlxSprite;
		
		private var text:Array = [
			"i'll never regret looking\nBENEATH THE SURFACE",
			"i'll never regret looking\nBENEATH THE SURFACE",
			"where i found the real you;\nthe one i fell for",
			"where i found the real you;\nthe one i fell for",
			"",
			"dedicated to Maru\nwe make the best team ;-)",
			"dedicated to Maru\nwe make the best team ;-)",
			"",
			"designed, programmed, tested, and hated in 48 hours",
			"alejandro cámara\napril 2014",
			"",
			"THANKS FOR PLAYING"];
		private var currentText:uint = 0;
		private var label:FlxText;
		
		private const TEXTSKIP_TIME:Number = 3;
		private var textSkipCount:Number = 0;
		
		private var readyForTransition:Boolean = false;
		private var dramaticPauseTime:Number = 0;
		private const DRAMATICPAUSE_TIME:Number = 2;
		
		private const PLAYER_MOVE_SPEED:Number = Math.PI / 4;
		
		private const ENDGAME_FLASHES:uint = 3;
		private var endGameFlashes:int = 4;
		private var isEndGameFlashes:Boolean = true;
		
		override public function create():void
		{
			endGameFlashes = ENDGAME_FLASHES;
			FlxG.flash(ColorAux.FADEFLASH_COLOR, ColorAux.FINALFLASH_DURATION, NextFlash);
			
			cameras = FlxG.cameras;
			cameras[0].bgColor = ColorAux.BACKGROUND_COLOR;
			
			for (var i:uint = 1; i < cameras.length; ++i)
			{
				//cameras[i].visible = false;
			}
			
			player = new PolarEndPlayer();
			player.MakeUnmovable();
			
			label = new FlxText(100, 468, 600, "");
			label.cameras = new Array();
			label.cameras[0] = cameras[0];
			label.size = 24;
			label.alignment = "center";
			label.color = ColorAux.TEXT_COLOR;
			label.shadow = ColorAux.TEXT_SHADOW_COLOR;
			
			heart = new FlxSprite(350, 350, Assets.PNG_HEART);
			heart.cameras = new Array();
			heart.cameras[0] = cameras[0];
		}
		
		override public function update():void
		{
			super.update();
			
			if (!isEndGameFlashes)
			{
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
			FlxG.switchState(new TitleState());
		}
		
		private function NextFlash():void
		{
			if (endGameFlashes >= 0)
			{
				FlxG.flash(ColorAux.GetFinalFlashColor(endGameFlashes--), ColorAux.FINALFLASH_DURATION, NextFlash);
			}
			if (endGameFlashes < 0)
			{
				add(player);
				add(label);
				add(heart);
			}
			else isEndGameFlashes = false;
		}
	}

}