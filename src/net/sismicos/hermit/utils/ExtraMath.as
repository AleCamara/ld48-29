package net.sismicos.hermit.utils 
{
	public class ExtraMath 
	{
		static public function Clamp(value:Number, min:Number, max:Number):Number
		{
			return Math.max(Math.min(value, max), min);
		}
	}

}