package net.sismicos.hermit.polar 
{
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import net.sismicos.hermit.Assets;
	import net.sismicos.hermit.polar.PolarSprite;
	import net.sismicos.hermit.utils.ExtraMath;
	
	public class PolarPlayer extends PolarSprite
	{
		private var s:Shape = new Shape();
		
		private var isTouchingFloor:Boolean = false;
		private var forceReleaseJump:Boolean = false;
		
		private const gravity:Number = 1500;
		private const lateralDrag:Number = 4;
		
		private const drMax:Number = 300;
		private const dpMax:Number = 150;
		private var dr:Number = 1000;
		private var dp:Number = 50;
		
		private var ddr:Number = 0;
		private var ddp:Number = 0;
		
		private var prevR:Number = 0;
		private var prevPhi:Number = 0;
		
		private var camera:FlxCamera;
		
		private var unmovable:Boolean = false;
		
		private var hasWon:Boolean = false;
		private var hasDied:Boolean = false;
		
		public function PolarPlayer(_r:Number = 10, _p:Number = 0, _rs:Number = 0.1, _ps:Number = 0.1) 
		{
			super(_r, _p, _rs, _ps);
			
			camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			camera.antialiasing = true;
			camera.bgColor = 0x00000000;
			FlxG.addCamera(camera);
			
			cameras = new Array();
			cameras[0] = camera;
			
			antialiasing = false;
			color = 0xE0E0E0;
			offset.x = 5;
			offset.y = 5;
			
			loadGraphic(Assets.PNG_PLAYER, false);
		}
		
		public function MakeUnmovable():void
		{
			unmovable = true;
			ddp = 0;
			ddr = 0;
		}
		
		public function MakeMovable():void
		{
			unmovable = false;
		}
		
		override public function update():void
		{
			super.update();
			
			prevR = GetRadiusIndex();
			prevPhi = GetPhiIndex();
			
			var timestep:Number = FlxG.elapsed;
				
			if (!unmovable)
			{
				// Lateral displacement
				if (FlxG.keys.RIGHT)
				{
					ddp += dp;
				}
				if (FlxG.keys.LEFT)
				{
					ddp -= dp;
				}
				
				// Vertical displacement
				if (isTouchingFloor && FlxG.keys.justPressed("UP"))
				{
					ddr += dr;
					isTouchingFloor = false;
				}
				if (forceReleaseJump || FlxG.keys.justReleased("UP"))
				{
					ddr = 0;
					forceReleaseJump = false;
				}
			}
			
			// Clamp displacement
			var ddrFinal:Number = ExtraMath.Clamp(ddr, -drMax * timestep, drMax * timestep);
			var ddpFinal:Number = ExtraMath.Clamp(ddp, -dpMax * timestep, dpMax * timestep);
			
			// Update position
			r += ddrFinal * timestep;
			p += ddpFinal * timestep;
			UpdatePosition();
			
			// Reset lateral displacement
			ddp = 0;
			
			// Gravity
			ddr -= gravity * timestep;
		}
		
		override public function draw():void
		{
			// Funky and expensive trail effect
			camera.buffer.colorTransform(camera.buffer.rect, new ColorTransform(1, 1, 1, 0.9));
			super.draw();
		}
		
		private function UpdatePosition():void
		{
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
			
			camera.angle = -(GetPhiInitial() * (180.0 / Math.PI)) - 90;
		}
		
		public function CollidesWith(object:PolarObject):void
		{
			var newR:Number = r;
			var newPhi:Number = p;
			var finalR:Number = newR;
			var finalPhi:Number = newPhi;
			
			if (object is PolarTile)
			{
				var tile:PolarTile = object as PolarTile;
				switch (tile.GetType())
				{
					case PolarTileType.DANGEROUS:
						hasDied = true;
						break;
					case PolarTileType.GOAL:
						hasWon = true;
						break;
				}
				if (!tile.isCollidable) return;
			}
			
			r = prevR;
			if (object.GetPolarRect().Overlaps(GetPolarRect()))
			{
				finalPhi = prevPhi;
			}
			
			p = prevPhi;
			r = newR;
			if (object.GetPolarRect().Overlaps(GetPolarRect()))
			{
				finalR = prevR;
				
				if (ddr < 0)
				{
					isTouchingFloor = true;
				}
				else
				{
					forceReleaseJump = true;
				}
				
				ddr = 0;
			}
			
			r = finalR;
			p = finalPhi;
			
			UpdatePosition();			
		}
		
		override public function GetPolarRect():PolarRect
		{
			var r0:Number = GetInRadius() - height * 0.5;
			var r1:Number = r0 + height;
			
			var arc:Number = Math.abs(Math.tan(width / r1));
			var p0:Number = GetPhiInitial() - arc * 0.5;
			return new PolarRect(r0, p0, r1 - r0, arc);
		}
	}

}