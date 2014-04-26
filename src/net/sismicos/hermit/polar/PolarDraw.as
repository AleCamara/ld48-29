package net.sismicos.hermit.polar 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	internal class PolarDraw 
	{
		// This code has been initially obtained from Mike Heavers' blog:
		// http://mikeheavers.com/main/code-item/creating_a_donut_wedge_in_flash_as3
		public static function DrawCircleSector(g:Graphics, x0:Number, y0:Number, radius:Number, arc:Number, startAngle:Number = 0):void
		{
			var segAngle:Number;
			var angle:Number;
			var angleMid:Number;
			var numOfSegs:Number;
			var ax:Number;
			var ay:Number;
			var bx:Number;
			var by:Number;
			var cx:Number;
			var cy:Number;
			
			// Move the pen
			g.moveTo(x0, y0);
			
			// No need to draw more than 360
			if (Math.abs(arc) > (2 * Math.PI)) 
			{
				arc = 2 * Math.PI;
			}
			
			numOfSegs = Math.ceil(Math.abs(arc) / (Math.PI / 4));
			segAngle = arc / numOfSegs;
			segAngle = segAngle;
			angle = startAngle;
			
			// Calculate the start point
			ax = x0 + Math.cos(angle) * radius;
			ay = y0 + Math.sin(angle) * radius;
			
			// Draw the first line
			g.lineTo(ax, ay);
			
			// Draw the arc
			for (var i:int = 0; i < numOfSegs; i++) 
			{
				angle += segAngle;
				angleMid = angle - (segAngle / 2);
				bx = x0 + Math.cos(angle) * radius;
				by = y0 + Math.sin(angle) * radius;
				cx = x0 + Math.cos(angleMid) * (radius / Math.cos(segAngle / 2));
				cy = y0 + Math.sin(angleMid) * (radius / Math.cos(segAngle / 2));
				g.curveTo(cx, cy, bx, by);
			}
			
			// Close the wedge
			g.lineTo(x0, y0);
		}
		
		// Draws in the graphics a sector of a circular annulus. It uses DrawCircleSector, therefore it is sensible to float precision errors.
		public static function DrawCircleAnnulusSectorFromSectors(g:Graphics, cx:Number, cy:Number, inRadius:Number, outRadius:Number, arc:Number, startAngle:Number = 0):void
		{
			DrawCircleSector(g, cx, cy, outRadius, arc, startAngle);
			DrawCircleSector(g, cx, cy, inRadius, arc, startAngle);
		}
		
		// Draws in the graphics a sector of a circular annulus.
		public static function DrawCircleAnnulusSector(g:Graphics, x0:Number, y0:Number, inRadius:Number, outRadius:Number, arc:Number, startAngle:Number = 0):void
		{
			const RHO_LEEWAY:Number = PolarAux.deltaR * 0.02;
			const PHI_LEEWAY:Number = Math.PI * 0.002;
			
			var segAngle:Number;
			var angle:Number;
			var angleMid:Number;
			var numOfSegs:Number;
			var ax:Number;
			var ay:Number;
			var bx:Number;
			var by:Number;
			var cx:Number;
			var cy:Number;
			
			// Add a bit of leeway to avoid separation between tiles
			startAngle -= Math.PI * PHI_LEEWAY;
			arc += Math.PI * PHI_LEEWAY;
			inRadius -= RHO_LEEWAY;
			outRadius += RHO_LEEWAY;
			
			// No need to draw more than 360
			if (Math.abs(arc) > (2 * Math.PI)) 
			{
				arc = 2 * Math.PI;
			}
			
			numOfSegs = Math.ceil(Math.abs(arc) / (Math.PI / 4));
			segAngle = arc / numOfSegs;
			segAngle = segAngle;
			angle = startAngle;
			
			var inX0:Number = x0 + inRadius * Math.cos(startAngle);
			var inY0:Number = y0 + inRadius * Math.sin(startAngle);
			var outX0:Number = x0 + outRadius * Math.cos(startAngle);
			var outY0:Number = y0 + outRadius * Math.sin(startAngle);
			var inX1:Number = x0 + inRadius * Math.cos(startAngle + arc);
			var inY1:Number = y0 + inRadius * Math.sin(startAngle + arc);
			var outX1:Number = x0 + outRadius * Math.cos(startAngle + arc);
			var outY1:Number = y0 + outRadius * Math.sin(startAngle + arc);
			
			// Draw straight side
			g.moveTo(inX0, inY0);
			g.lineTo(outX0, outY0);
			
			// Draw the arc from out0 to out1
			for (var i:int = 0; i < numOfSegs-1; i++) 
			{
				angle += segAngle;
				angleMid = angle - (segAngle / 2);
				bx = x0 + outRadius * Math.cos(angle);
				by = y0 + outRadius * Math.sin(angle);
				cx = x0 + outRadius * Math.cos(angleMid) / Math.cos(segAngle / 2);
				cy = y0 + outRadius * Math.sin(angleMid) / Math.cos(segAngle / 2);
				g.curveTo(cx, cy, bx, by);
			}
			
			// Final segment of the arc
			angle = startAngle + arc;
			angleMid = angle - (segAngle / 2);
			cx = x0 + outRadius * Math.cos(angleMid) / Math.cos(segAngle / 2);
			cy = y0 + outRadius * Math.sin(angleMid) / Math.cos(segAngle / 2);
			g.curveTo(cx, cy, outX1, outY1);
			
			// Draw other straight side
			g.moveTo(outX1, outY1);
			g.lineTo(inX0, inY0);
			
			// Draw the arc from in1 to in0
			angle = startAngle;
			for (var j:int = 0; j < numOfSegs-1; i++) 
			{
				angle += segAngle;
				angleMid = angle - (segAngle / 2);
				bx = x0 + inRadius * Math.cos(angle);
				by = y0 + inRadius * Math.sin(angle);
				cx = x0 + inRadius * Math.cos(angleMid) / Math.cos(segAngle / 2);
				cy = y0 + inRadius * Math.sin(angleMid) / Math.cos(segAngle / 2);
				g.curveTo(cx, cy, bx, by);
			}
			
			// Final segment of the arc
			angle = startAngle + arc;
			angleMid = angle - (segAngle / 2);
			cx = x0 + inRadius * Math.cos(angleMid) / Math.cos(segAngle / 2);
			cy = y0 + inRadius * Math.sin(angleMid) / Math.cos(segAngle / 2);
			g.curveTo(cx, cy, inX1, inY1);
		}
		
		public static function DrawDummy(g:Graphics, x0:Number, y0:Number, x1:Number, y1:Number):void
		{
			g.moveTo(x0, y0);
			g.lineTo(x0, y1);
			g.lineTo(x1, y1);
			g.lineTo(x1, y0);
			g.lineTo(x0, y0);
		}
	}

}