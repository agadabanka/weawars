﻿package  {	import flash.display.*;	import Field;	import Monsters;	import DashBoard;	import Player;	import Creature;	public class Game extends MovieClip{		public var grid_m:Number 		= 20;		public var grid_n:Number 		= 20;		public var grid_size:Number		= 20;		public var field:Field;		public var monsters:Monsters;		public var dashBoard:DashBoard;		public var player:Player;				public function Game(l_stage:Stage) {			// constructor code			field 	  = new Field( this, l_stage );			addChild( field );			monsters  = new Monsters(this, 10 );			addChild( monsters );			field.setMonsters( monsters );			dashBoard = new DashBoard( this, l_stage );			addChild( dashBoard );			player	  = new Player( this );		}				public function beginAttack( ){			field.fieldmode = Field.COMBAT;			field.enableTowerRange( );			monsters.addToField( );		}				public function endAttack( ){			trace('calling monsters.removefromfield');			monsters.removeFromField( );			field.disableTowerRange( );			field.fieldmode = Field.NOCHANGE;		}				public function gameover( ){			endAttack( );		}				public function terminate( ){			field.removeTowers( );			field.unsetMonsters( );		}			}	}