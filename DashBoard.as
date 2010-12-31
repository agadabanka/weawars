﻿package{	import flash.display.*;	import flash.geom.Point;	import Field;	import Monsters;	import DboardTex;		public class DashBoard extends Sprite{		private var purchasexy:Point;  		private var startxy:Point;	  		public var field:Field;		public var monsters:Monsters;		public var game:Game;		private var stage_v:Stage;				public function DashBoard( l_game:Game, l_stage:Stage) {			game		= l_game;			stage_v		= l_stage;			field 		= game.field;			monsters	= game.monsters;						var bg 		= new DboardTex( );			bg.x		= field.grid_m*field.grid_size;			bg.y		= 0;			bg.width	= stage_v.stageWidth - bg.x;			bg.height	= stage_v.stageHeight;			addChild( bg );			purchasexy	= new Point(field.grid_m*field.grid_size+field.grid_size, field.grid_n*field.grid_size-2*field.grid_size);			startxy		= new Point( purchasexy.x, purchasexy.y - 25 ); //25 assumed to be the button size.						var purchasebtn = new PurchaseButton( this, purchasexy 	  ); //adds the button as well					var startbtn	= new StartButton	( this, startxy		  );		}			}	}import fl.controls.Button;import flash.geom.Point;import flash.events.*;import flash.text.TextFormat;import flash.display.*;import Monsters;import Field;class PurchaseButton extends Sprite{	private var field:Field;	private var btn:Button;	private var dboard:DashBoard;		public function PurchaseButton( l_dboard:DashBoard, xy:Point ){		dboard= l_dboard;		field = dboard.field;		btn = new Button( )		btn.x = xy.x;		btn.y = xy.y		btn.label  = "Buy Tower $10";		btn.setStyle( "textFormat", new TextFormat( "Comic Sans MS")) ;		btn.addEventListener( MouseEvent.CLICK, addTower, false, 0, true );		addChild(btn);		dboard.addChild(this);	}		private function addTower( eve:MouseEvent ){		if( dboard.game.money >= 10 ){			dboard.game.money -= 10;			trace('money left :: ' + dboard.game.money );			field.enablePlacement( );		}else{			trace( 'not enough money left ::' + dboard.game.money );		}	}}class StartButton extends Sprite{	private var monsters:Monsters;	private var field:Field;	private var btn:Button;		public function StartButton( dboard:DashBoard, xy:Point ){		monsters = dboard.monsters;		field	 = dboard.field;		btn = new Button( );				btn.x = xy.x;		btn.y = xy.y		btn.label  = "Start!";		btn.setStyle( "textFormat", new TextFormat( "Comic Sans MS")) ;		btn.addEventListener( MouseEvent.CLICK, beginAttack, false, 0, true );		addChild(btn);		dboard.addChild(this);	}		private function beginAttack( eve:MouseEvent ){			field.fieldmode = Field.COMBAT;			field.enableTowerRange( );			monsters.addToField( );	}}