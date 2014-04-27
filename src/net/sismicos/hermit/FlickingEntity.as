package net.sismicos.hermit 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class FlickingEntity extends FlxSprite
	{
		private var flickTime:Number;
		private var elapsedTime:Number;
		
		private var deltaAlpha:Number;
		
		public function FlickingEntity(flickTime:Number, X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
			
			this.flickTime = flickTime;
			elapsedTime = 0;
			deltaAlpha = - 1.0 / flickTime;
		}
		
		override public function update():void
		{
			elapsedTime += FlxG.elapsed;
			if (elapsedTime > flickTime)
			{
				elapsedTime -= flickTime;
				deltaAlpha = -deltaAlpha;
			}
			alpha += deltaAlpha * FlxG.elapsed;
		}
	}

}