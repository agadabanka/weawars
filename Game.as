﻿package  {	import flash.display.*;	import Field;	import Monsters;	import DashBoard;	public class Game extends MovieClip{		public var grid_m:Number 		= 20;		public var grid_n:Number 		= 20;		public var grid_size:Number		= 20;		public var field:Field;		public var monsters:Monsters;		public var dashBoard:DashBoard;				public function Game(l_stage:Stage) {			// constructor code			field 	  = new Field( this, l_stage );			addChild( field );			monsters  = new Monsters(this, 10 );			addChild( monsters );			field.setMonsters( monsters );			dashBoard = new DashBoard( this, l_stage );			addChild( dashBoard );						//monsters.addToField( ); //introduce the monsters to the field		}	}	}