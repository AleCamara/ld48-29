package net.sismicos.hermit.polar 
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import net.sismicos.hermit.polar.PolarPlayer;
	
	public class PolarEndPlayer extends PolarPlayer
	{
		static private const ROTATION_SPEED:Number = Math.PI / 4 * 70;
		
		public function PolarEndPlayer() 
		{
			super(5, 30);
		}
		
		override public function update():void
		{
			p += (ROTATION_SPEED * FlxG.elapsed) * 2 * Math.PI / (PolarAux.numAngles - 1);
			
			// Make sure r is always positive
			if (r < 0) r = Math.abs(r);
			
			// Make sure p is in the range [0, NA-1)
			while (p < 0) p += PolarAux.numAngles - 1;
			while (p >= PolarAux.numAngles) p -= PolarAux.numAngles - 1;
			
			// Global position
			var pos:FlxPoint = PolarAux.CalculateCartesianPointFromIndex(r, p);
			x = pos.x;
			y = pos.y;
			
			// Orient apex toward centre
			var a:Number = PolarAux.GetAngleFromIndex(p) * (180.0 / Math.PI) - 90;
			angle = a;
		}
	}

}