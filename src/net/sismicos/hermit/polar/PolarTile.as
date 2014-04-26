package net.sismicos.hermit.polar 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import net.sismicos.hermit.polar.PolarDraw;
	import net.sismicos.hermit.polar.PolarObject;
	
	public class PolarTile extends PolarObject
	{
		internal var s:Shape = new Shape();
		private var color:uint = 0xE0E0E0;
		
		internal var collideCallback:Function;
		
		public function PolarTile(_r:Number = 0, _p:Number = 0, _rs:Number = 1, _ps:Number = 1, _callback:Function = null):void
		{
			super(_r, _p, _rs, _ps);
			collideCallback = _callback;
			UpdateGraphics();
		}
		
		public function SetColor(_color:uint):void
		{
			if (_color != color)
			{
				color = _color;
				UpdateGraphics();
			}
		}
		
		private function UpdateGraphics():void
		{
			var inR:Number = GetInRadius();
			var outR:Number = GetOutRadius();
			var p:Number = GetPhiInitial();
			var pSpan:Number = GetPhiFinal() - p;
			
			s.graphics.clear();
			s.graphics.beginFill(color, 1.0);
			PolarDraw.DrawCircleAnnulusSector(s.graphics, PolarAux.centerX, PolarAux.centerY, inR, outR, pSpan, p);
			s.graphics.endFill();
		}
	}

}