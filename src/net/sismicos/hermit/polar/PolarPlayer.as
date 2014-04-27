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
		private var doubleJumpEnabled:Boolean = false;
		
		private const gravity:Number = 1500;
		private const lateralDrag:Number = 4;
		
		private const drMax:Number = 500;
		private const dpMax:Number = 150;
		private var dr:Number = 1000;
		private var dp:Number = 50;
		
		private var ddr:Number = 0;
		private var ddp:Number = 0;
		
		private var prevR:Number = 0;
		private var prevPhi:Number = 0;
		
		private var camera:FlxCamera;
		
		private var isCollidable:Boolean = true;
		
		private var checkpoint:PolarPoint;
		
		private const PLAYER_MOVE_TIME:Number = 2;
		private var unmovable:Boolean = false;
		private var isMoving:Boolean = false;
		private var moveSpeedR:Number = 0;
		private var moveSpeedPhi:Number = 0;
		private var moveTime:Number = 0;
		
		private var hasWon:Boolean = false;
		private var hasDied:Boolean = false;
		
		public function PolarPlayer(_r:Number = 16, _p:Number = 0.5, _rs:Number = 0.1, _ps:Number = 0.1) 
		{
			super(_r, _p, _rs, _ps);
			
			checkpoint = new PolarPoint(_r, _p);
			
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
		
		public function MoveToLastCheckpoint(callback:Function = null):void
		{
			unmovable = true;
			isCollidable = false;
			isMoving = true;
			
			moveSpeedR = (checkpoint.r - r) / PLAYER_MOVE_TIME;
			moveSpeedPhi = (checkpoint.phi - p) / PLAYER_MOVE_TIME;
			var altSpeedPhi:Number;
			if (p > checkpoint.phi)
			{
				altSpeedPhi = ((checkpoint.phi + PolarAux.numAngles - 1) - p) / PLAYER_MOVE_TIME;
				if (Math.abs(altSpeedPhi) < Math.abs(moveSpeedPhi)) moveSpeedPhi = altSpeedPhi;
			}
			else
			{
				altSpeedPhi = ((checkpoint.phi - PolarAux.numAngles + 1) - p) / PLAYER_MOVE_TIME;
				if (Math.abs(altSpeedPhi) < Math.abs(moveSpeedPhi)) moveSpeedPhi = altSpeedPhi;
			}
			
			moveTime = 0;
			
			if (null != callback) callback();
		}
		
		public function Die():void
		{
			hasDied = true;
			MoveToLastCheckpoint();
		}
		
		public function Undie():void
		{
			hasDied = false;
		}
		
		public function Unwin():void
		{
			hasWon = false;
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
		
		public function HasDied():Boolean
		{
			return hasDied;
		}
		
		public function HasWon():Boolean
		{
			return hasWon;
		}
		
		public function CollidesWith(object:PolarObject):void
		{
			if (!isCollidable) return; 
			
			var newR:Number = r;
			var newPhi:Number = p;
			var finalR:Number = newR;
			var finalPhi:Number = newPhi;
			
			if (object is PolarTile)
			{
				
				var tile:PolarTile = object as PolarTile;
				switch (tile.GetType())
				{
					case PolarTileType.CHECKPOINT:
						UpdateCheckpoint(tile.GetRadiusIndex(), tile.GetPhiIndex());
						break;
					case PolarTileType.DANGEROUS:
						Die();
						break;
					case PolarTileType.GOAL:
						hasWon = true;
						UpdateCheckpoint(PolarAux.numRadii+1, 0);
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
					doubleJumpEnabled = false;
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
				if ((isTouchingFloor || doubleJumpEnabled) && FlxG.keys.justPressed("UP"))
				{
					ddr += dr;
					isTouchingFloor = false;
				}
				if (forceReleaseJump || FlxG.keys.justReleased("UP"))
				{
					ddr = 0;
					doubleJumpEnabled = (!forceReleaseJump && !doubleJumpEnabled);
					forceReleaseJump = false;
				}
			}
			
			// Clamp displacement
			var ddrFinal:Number = ExtraMath.Clamp(ddr, -drMax * timestep, drMax * timestep);
			var ddpFinal:Number = ExtraMath.Clamp(ddp, -dpMax * timestep, dpMax * timestep);
			
			// Ignore clamp and everything else when autonomously moving
			if (isMoving)
			{
				moveTime += timestep;
				ddrFinal = moveSpeedR;
				ddpFinal = moveSpeedPhi;
				
				if (moveTime > PLAYER_MOVE_TIME)
				{
					OnMoveToFinished();
				}
			}
			
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
		
		override public function GetPolarRect():PolarRect
		{
			var r0:Number = GetInRadius() - height * 0.5;
			var r1:Number = r0 + height;
			
			var arc:Number = Math.abs(Math.tan(width / r1));
			var p0:Number = GetPhiInitial() - arc * 0.5;
			return new PolarRect(r0, p0, r1 - r0, arc);
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
			
			// Update rect
			var r1:Number = GetInRadius() + height * 0.5;
			var arc:Number = Math.abs(Math.tan(width / r1));
			rs = PolarAux.GetIndexFromRadiusSpan(height);
			ps = PolarAux.GetIndexFromAngle(arc);
		}
		
		private function UpdateCheckpoint(tileR:Number, tilePhi:Number):void
		{
			if (checkpoint.PolarDistanceTo(new PolarPoint(tileR, tilePhi)) > 2)
			{
				checkpoint.r = tileR + 1.2 + GetRadiusSpanIndex() * 0.5;
				checkpoint.phi = tilePhi + 0.5 - GetPhiSpanIndex() * 0.5;
			}
		}
		
		private function OnMoveToFinished():void
		{
			unmovable = false;
			isMoving = false;
			isCollidable = true;
		}
	}

}