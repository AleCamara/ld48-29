package net.sismicos.hermit.polar 
{
	import flash.display.BitmapData;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	internal class PolarAux 
	{
		public static const centerX:Number = FlxG.width / 2;
		public static const centerY:Number = FlxG.height / 2;
		
		public static const numRadii:int = 10;
		public static const innerRadii:Number = 200.0;
		public static const outerRadii:Number = 375.0;
		public static const deltaR:Number = (outerRadii - innerRadii) / (numRadii - 1);
		
		public static const numAngles:int = 20;
		public static const deltaA:Number = 2.0 * Math.PI / (numAngles - 1);
		
		public static function GetRadiusFromInt(index:int):Number
		{
			return innerRadii + index * deltaR;
		}
		
		public static function GetAngleFromInt(index:int):Number
		{
			return (index % numAngles) * deltaA;
		}
		
		public static function IsBitmapALevel(bm:BitmapData)
		{
			if (bm.height != numRadii) return false;
			if (bm.width != numAngles) return false;
			return true;
		}
		
		public static function CalculateStartingPoint(radius:Number, angle:Number):FlxPoint
		{
			var x:Number = centerX + radius * Math.cos(angle);
			var y:Number = centerY - radius * Math.sin(angle);
			return new FlxPoint(x, y);
		}
	}

}