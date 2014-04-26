package net.sismicos.hermit.polar 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxRect;
	import net.sismicos.hermit.polar.PolarAux;
	
	public class PolarSprite extends FlxSprite
	{
		protected var r:Number = 0;
		protected var p:Number = 0;
		protected var rs:Number = 1;
		protected var ps:Number = 1;
		
		public function PolarSprite(_r:Number = 0, _p:Number = 0, _rs:Number = 1, _ps:Number = 1) 
		{
		  r = _r;
		  p = _p;
		  rs = _rs;
		  ps = _ps;
		}
		
		public function GetRadiusIndex():Number
		{
			return r;
		}
		
		public function GetRadiusSpanIndex():Number
		{
			return rs;
		}
		
		public function GetInRadius():Number
		{
			return PolarAux.GetRadiusFromIndex(r);
		}
		
		public function GetOutRadius():Number
		{
			return PolarAux.GetRadiusFromIndex(r + rs);
		}
		
		public function GetPhiIndex():Number
		{
			return p;
		}
		
		public function GetPhiSpanIndex():Number
		{
			return ps;
		}
		
		public function GetPhiSpan():Number
		{
			return PolarAux.GetAngleFromIndex(ps);
		}
		
		public function GetPhiInitial():Number
		{
			return PolarAux.GetAngleFromIndex(p);
		}
		
		public function GetPhiFinal():Number
		{
			return PolarAux.GetAngleFromIndex(p + ps);
		}
		
		public function GetPolarRect():PolarRect
		{
			var r0:Number = GetInRadius();
			var r1:Number = GetOutRadius();
			var p0:Number = GetPhiInitial();
			var pSpan:Number = GetPhiSpan();
			return new PolarRect(r0, p0, r1 - r0, pSpan);
		}
	}

}