package net.sismicos.hermit.polar 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxBasic;
	import net.sismicos.hermit.polar.PolarDraw;
	import net.sismicos.hermit.polar.PolarObject;
	import net.sismicos.hermit.polar.PolarTileType;
	import net.sismicos.hermit.utils.ColorAux;
	
	public class PolarTile extends PolarObject
	{
		internal var s:Shape = new Shape();
		private var color:uint = 0xE0E0E0;
		internal var collideCallback:Function;
		private var type:PolarTileType = PolarTileType.NORMAL;		
		
		public static function DefaultCollide(self:PolarTile, object:FlxBasic):void
		{
			if (object is PolarPlayer)
			{
				var player:PolarPlayer = object as PolarPlayer;
				player.CollidesWith(self);
			}
		}
		
		public function PolarTile(_type:PolarTileType, _r:Number = 0, _p:Number = 0, _rs:Number = 1, _ps:Number = 1, _callback:Function = null):void
		{
			super(_r, _p, _rs, _ps);
			
			if (null != _callback) collideCallback = _callback;
			else collideCallback = DefaultCollide;
			
			SetType(_type);
		}
		
		public function SetType(type:PolarTileType):void
		{
			this.type = type;
			
			color = ColorAux.GetTileColor(type);
			
			UpdateGraphics();
		}
		
		public function GetType():PolarTileType
		{
			return type;
		}
		
		private function UpdateGraphics():void
		{
			var inR:Number = GetInRadius();
			var outR:Number = GetOutRadius();
			var p:Number = GetPhiInitial();
			var pSpan:Number = GetPhiFinal() - p;
			
			var alphaUINT:uint = (color >> 24) & 0xFF;
			var alpha:Number = (alphaUINT) / 255;
			
			s.graphics.clear();
			s.graphics.beginFill(color, alpha);
			PolarDraw.DrawCircleAnnulusSector(s.graphics, PolarAux.centerX, PolarAux.centerY, inR, outR, pSpan, p);
			s.graphics.endFill();
		}
	}

}