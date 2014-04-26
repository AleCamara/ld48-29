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
		
		public function GetRadius():Number
		{
			return PolarAux.GetRadiusFromIndex(r);
		}
		
		public function GetRadiusSpan():Number
		{
			return PolarAux.GetRadiusFromIndex(rs);
		}
		
		public function GetPhiIndex():Number
		{
			return p;
		}
		
		public function GetPhiSpanIndex():Number
		{
			return ps;
		}
		
		public function GetPhi():Number
		{
			return PolarAux.GetAngleFromIndex(p);
		}
		
		public function GetPhiSpan():Number
		{
			return PolarAux.GetAngleFromIndex(ps);
		}
		
		public function GetPolarRect():FlxRect
		{
			var rn:Number = PolarAux.GetRadiusFromIndex(r);
			var pn:Number = PolarAux.GetRadiusFromIndex(p);
			var rsn:Number = PolarAux.GetRadiusFromIndex(rs);
			var psn:Number = PolarAux.GetRadiusFromIndex(ps);
			return new FlxRect(rn, pn, rsn, psn);
		}
	}

}