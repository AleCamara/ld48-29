package net.sismicos.hermit.polar 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import net.sismicos.hermit.Assets;
	import net.sismicos.hermit.polar.PolarSprite;
	
	public class PolarPlayer extends PolarSprite
	{
		private var s:Shape = new Shape();
		
		private var dr:Number = 10;
		private var dp:Number = 0.05;
		
		private var ddr:Number = -0.5;
		
		public function PolarPlayer(_r:Number = 10, _p:Number = 0, _rs:Number = 1, _ps:Number = 1) 
		{
			super(_r, _p, _rs, _ps);
			
			antialiasing = false;
			color = 0xFF0000;
			offset.x = 5;
			offset.y = 5;
			
			loadGraphic(Assets.PNG_PLAYER, false);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.RIGHT)
				p -= dp;
			if (FlxG.keys.LEFT)
				p += dp;
				
			r -= dr * FlxG.elapsed;
			r = Math.abs(r);
				
			UpdatePosition();
		}
		
		private function UpdatePosition():void
		{
			var pos:FlxPoint = PolarAux.CalculateCartesianPointFromIndex(r, p);
			x = pos.x;
			y = pos.y;
			
			var a:Number = PolarAux.GetAngleFromIndex(p) * (180.0 / Math.PI) + 90;
			angle = -a;
		}
	}

}