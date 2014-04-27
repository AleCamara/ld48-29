package net.sismicos.hermit.polar 
{
	public final class PolarTileMapLayer 
	{
		public static const FIRST:PolarTileMapLayer = new PolarTileMapLayer(1, 5);
		public static const SECOND:PolarTileMapLayer = new PolarTileMapLayer(0.4, 1);
		public static const THIRD:PolarTileMapLayer = new PolarTileMapLayer(0.1, 0.4);
		
		public static function GetNextLayer(layer:PolarTileMapLayer):PolarTileMapLayer
		{
			switch (layer)
			{
				case SECOND:
					return FIRST;
					
				case THIRD:
					return SECOND;
					
				case FIRST:
				default:
					return THIRD;
			}
		}
		
		public var zoom:Number;
		public var nextZoom:Number;
		
		public function PolarTileMapLayer(zoom:Number, nextZoom:Number)
		{
			this.zoom = zoom;
			this.nextZoom = nextZoom;
		}
	}

}