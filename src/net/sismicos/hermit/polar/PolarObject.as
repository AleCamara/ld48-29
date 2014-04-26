package net.sismicos.hermit.polar 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import net.sismicos.hermit.polar.PolarAux;
	
	public class PolarObject extends FlxObject
	{
		protected var r:Number = 0;
		protected var p:Number = 0;
		protected var rs:Number = 1;
		protected var ps:Number = 1;
		
		public function PolarObject(_r:Number = 0, _p:Number = 0, _rs:Number = 1, _ps:Number = 1) 
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
		
		public function GetPhiInitial():Number
		{
			return PolarAux.GetAngleFromIndex(p);
		}
		
		public function GetPhiFinal():Number
		{
			return PolarAux.GetAngleFromIndex(p + ps);
		}
		
		public function GetPolarRect():FlxRect
		{
			var r0:Number = GetInRadius();
			var p0:Number = GetPhiInitial();
			var r1:Number = GetOutRadius();
			var p1:Number = GetPhiFinal();
			return new FlxRect(r0, p0, r1 - r0, p1 - p0);
		}
	}

}