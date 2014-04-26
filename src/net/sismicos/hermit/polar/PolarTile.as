package net.sismicos.hermit.polar 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import net.sismicos.hermit.polar.PolarDraw;
	
	public class PolarTile extends FlxObject
	{
		internal var s:Shape = new Shape();
		
		// Geometry
		private var radius:int;
		private var phi:int;
		private var rSpan:int = 1;
		private var pSpan:int = 1;
		
		private var colour:uint = 0xE0E0E0;
		
		public function PolarTile(r:int, p:int):void
		{
			radius = r;
			phi = p;
			
			UpdateGraphics();
		}
		
		override public function draw():void
		{
			super.draw();
			
			if (!visible) return;
			
			for (var i:uint = 0; i < cameras.length; ++i)
			{
				cameras[i].buffer.draw(s);
			}
		}
		
		private function UpdateGraphics():void
		{
			var inR:Number = PolarAux.GetRadiusFromInt(radius);
			var outR:Number = PolarAux.GetRadiusFromInt(radius + 1);
			var p:Number = PolarAux.GetAngleFromInt(phi);
			
			s.graphics.clear();
			s.graphics.beginFill(colour, 1.0);
			PolarDraw.DrawCircleAnnulusSector(s.graphics, PolarAux.centerX, PolarAux.centerY, inR, outR, PolarAux.deltaA, p);
			//PolarDraw.DrawDummy(s.graphics, 100, 100, 200, 200);
			s.graphics.endFill();
		}
	}

}