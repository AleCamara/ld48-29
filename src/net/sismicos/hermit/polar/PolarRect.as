package net.sismicos.hermit.polar 
{
	import net.sismicos.hermit.polar.PolarPoint;
	
	public class PolarRect 
	{
		public var r:Number;
		public var phi:Number;
		public var rSpan:Number;
		public var phiSpan:Number;
		
		public function PolarRect(_r:Number, _phi:Number, _rSpan:Number, _phiSpan:Number)
		{
			r = _r;
			phi = _phi;
			rSpan = _rSpan;
			phiSpan = _phiSpan;
		}
		
		public function GetPolarPoints():Array
		{
			var points:Array = new Array(4);
			points[0] = new PolarPoint(r, phi);
			points[1] = new PolarPoint(r + rSpan, phi);
			points[2] = new PolarPoint(r + rSpan, phi + phiSpan);
			points[3] = new PolarPoint(r, phi + phiSpan);
			return points;
		}
		
		public function ContainsPoint(point:PolarPoint):Boolean
		{
			while (point.phi < 0) point.phi += 2 * Math.PI;
			while (point.phi >= 2 * Math.PI) point.phi -= 2 * Math.PI;
			
			return ((point.r > r) && ((point.r - r) <= rSpan)
				&& (((point.phi >= phi) && ((point.phi - phi) <= phiSpan)) 
					|| ((phi > point.phi) && (((2 * Math.PI) + point.phi - phi) <= phiSpan))));
		}
		
		public function ContainsPolarRect(rect:PolarRect):Boolean
		{
			var contains:Boolean = true;
			var rectPoints:Array = rect.GetPolarPoints();
			for (var i:uint = 0; i < rectPoints.length; ++i)
			{
				if (!ContainsPoint(rectPoints[i]))
				{
					contains = false;
					break;
				}
			}
			return contains;
		}
		
		public function Overlaps(rect:PolarRect):Boolean
		{
			var rectPoints:Array = rect.GetPolarPoints();
			for (var i:uint = 0; i < rectPoints.length; ++i)
			{
				if (ContainsPoint(rectPoints[i])) return true;
			}
			return false;
		}
	}

}