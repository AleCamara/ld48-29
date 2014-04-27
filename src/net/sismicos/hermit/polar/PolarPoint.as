package net.sismicos.hermit.polar 
{
	public class PolarPoint 
	{
		public var r:Number;
		public var phi:Number;
		
		public function PolarPoint(_r:Number, _phi:Number) 
		{
			r = _r;
			phi = _phi;
		}
		
		public function PolarDistanceTo(target:PolarPoint):Number
		{
			var dr:Number = r - target.r;
			var dphi:Number = phi - target.phi;
			return Math.sqrt(dr * dr + dphi * dphi);
		}
	}

}