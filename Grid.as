﻿package {	import flash.display.*;	import flash.events.MouseEvent;		import flash.geom.*;	import Tower;	import Field;	import Monsters;		public class Grid extends Sprite{		public var  pi:Number, 					pj:Number,					gx:Number,					gy:Number,					color:Number;		public  var grid_size:Number;		public  var field:Field;		public  var hasTower:Boolean;		public  var tower:Tower;		public  var range:Range;		private var spot:Spot;		private static const RED:int   = 0xFF0000;		public var monsters:Monsters;				public function Grid(l_field:Field, l_pi:Number, l_pj:Number,l_gx:Number,							 l_gy:Number, l_grid_size:Number, l_color:Number){			pi = l_pi; pj = l_pj ; gx = l_gx; gy = l_gy; grid_size=l_grid_size;						field = l_field;			color = l_color;			hasTower  = false;			x = gx; y = gy;			range = new Range( grid_size );			spot  = new Spot( this );			addChild( spot  );		}				public function placeTower( ){			spot.enableListeners( );		}				public function stopPlacement( ){			spot.disableListeners( );		}				public function enableRange( ){			if( hasTower ){				tower.addChild( range );				range.alpha = 0;			}		}		}	}import flash.display.*;import flash.events.MouseEvent;import flash.geom.Point;import Field;import Range;import TankTex;class Spot extends Sprite{	private static const RED:int   = 0xFF0000;	private var range:Range;	private var field:Field;	private var grid:Grid;	private var tankTex:TankTex;		public function Spot( l_grid:Grid ){		grid = l_grid;		range = grid.range;		field = grid.field;		tankTex = new TankTex( );		tankTex.width = tankTex.height = grid.grid_size;		addChild( tankTex );		/*graphics.beginFill ( RED );		graphics.drawRect( 0, 0, grid.grid_size, grid.grid_size );		graphics.endFill( );*/				alpha = 0;	}		public function enableListeners( ){		addEventListener( MouseEvent.MOUSE_OVER, handleMouseOver, false, 0, true );		addEventListener( MouseEvent.MOUSE_OUT , handleMouseOut , false, 0, true );				addEventListener( MouseEvent.CLICK	   , handleClick	, false, 0, true );	}		public function disableListeners( ){		removeEventListener( MouseEvent.MOUSE_OVER, handleMouseOver);		removeEventListener( MouseEvent.MOUSE_OUT , handleMouseOut );		removeEventListener( MouseEvent.CLICK	  , handleClick	   );	}		private function handleMouseOver( eve: MouseEvent ){		if( !grid.hasTower ){			alpha 		= 0.5;			parent.addChild( range );		}	}	private function handleMouseOut( eve: MouseEvent ){		if(!grid.hasTower ){			alpha 		= 0;			parent.removeChild( range );		}	}		private function handleClick( eve:MouseEvent ){		if(!grid.hasTower){			grid.hasTower = true;			removeChild( tankTex );			alpha = 1;			grid.tower = new Tower( grid.range, grid.monsters, grid.grid_size );			addChild( grid.tower );			if (field.fieldmode == Field.PLACEMENT)				parent.removeChild( range ); //equivalent of a mouseout ###needs removal if not added in Tower!!			else if (field.fieldmode == Field.COMBAT){ //in combat mode, so hide range and start shooting!				grid.enableRange( );			}			field.disablePlacement();		}	}}