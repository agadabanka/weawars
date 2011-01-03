﻿/***********************************************************************	Author: Amith Tudur 	This file is part of Weawars.    Weawars is free software: you can redistribute it and/or modify    it under the terms of the GNU General Public License as published by    the Free Software Foundation, either version 3 of the License, or    (at your option) any later version.    Weawars is distributed in the hope that it will be useful,    but WITHOUT ANY WARRANTY; without even the implied warranty of    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the    GNU General Public License for more details.    You should have received a copy of the GNU General Public License    along with Weawars.  If not, see <http://www.gnu.org/licenses/>.***********************************************************************/package{	import flash.display.*;	import flash.geom.Point;	import Field;	import Waves;	import DboardTex;	import Player;	import flash.sensors.Accelerometer;		public class DashBoard extends Sprite{		private var purchasexy:Point;  		private var startxy:Point;	 		private var moneyxy:Point;		private var healthxy:Point;		private var wavexy:Point;		private var restartxy:Point;				public var field:Field;		public var waves:Waves;		public var game:Game;		private var stage_v:Stage;		public var moneyBox:MoneyBox;		public var healthBox:HealthBox;		public var waveBox:WaveBox;				public function DashBoard( l_game:Game, l_stage:Stage) {			game		= l_game;			stage_v		= l_stage;			field 		= game.field;			waves		= game.waves;						var bg 		= new DboardTex( );			bg.x		= field.grid_m*field.grid_size;			bg.y		= 0;			bg.width	= stage_v.stageWidth - bg.x;			bg.height	= stage_v.stageHeight;			addChild( bg );			purchasexy	= new Point(field.grid_m*field.grid_size+field.grid_size, field.grid_n*field.grid_size-2*field.grid_size);			startxy		= new Point( purchasexy.x, purchasexy.y - 25 ); //25 assumed to be the button size.			moneyxy		= new Point( purchasexy.x, startxy.y - 25);			healthxy	= new Point( purchasexy.x, moneyxy.y - 25);			wavexy		= new Point( purchasexy.x, healthxy.y - 25 );			restartxy	= new Point( purchasexy.x, wavexy.y - 4*25 );			var purchasebtn = new PurchaseButton( this, purchasexy 	  ); //adds the button as well					var startbtn	= new StartButton	( this, startxy		  );			moneyBox		= new MoneyBox		( this, moneyxy 	  );			healthBox		= new HealthBox		( this, healthxy 	  );			waveBox			= new WaveBox		( this, wavexy		  );			var restartbtn	= new RestartButton	( this, restartxy	  );		}					}	}import fl.controls.Button;import flash.geom.Point;import flash.events.*;import flash.text.*;import flash.display.*;import Waves;import Field;class PurchaseButton extends Sprite{	private var field:Field;	private var btn:Button;	private var dboard:DashBoard;		public function PurchaseButton( l_dboard:DashBoard, xy:Point ){		dboard= l_dboard;		field = dboard.field;		btn = new Button( )		btn.x = xy.x;		btn.y = xy.y		btn.label  = "Buy Tower $10";		btn.setStyle( "textFormat", new TextFormat( "Comic Sans MS")) ;		btn.addEventListener( MouseEvent.CLICK, addTower, false, 0, true );		addChild(btn);		dboard.addChild(this);	}		private function addTower( eve:MouseEvent ){		if( field.fieldmode == Field.PLACEMENT ||		   	field.fieldmode == Field.COMBAT )			field.addTower( );	}}class StartButton extends Sprite{	private var waves:Waves;	private var field:Field;	private var btn:Button;	private var dboard:DashBoard;		public function StartButton( l_dboard:DashBoard, xy:Point ){		dboard 	 = l_dboard;		waves 	 = dboard.waves;		field	 = dboard.field;		btn 	 = new Button( );				btn.x = xy.x;		btn.y = xy.y		btn.label  = "Start!";		btn.setStyle( "textFormat", new TextFormat( "Comic Sans MS")) ;		btn.addEventListener( MouseEvent.CLICK, beginAttack, false, 0, true );		addChild(btn);		dboard.addChild(this);	}		private function beginAttack( eve:MouseEvent ){		if( field.fieldmode == Field.PLACEMENT ){			waves.beginAttack( );		}	}}class MoneyBox extends Sprite{	private var moneylabel:TextField;		public function MoneyBox( dboard:DashBoard, xy:Point ){		moneylabel 				= new TextField();		moneylabel.autoSize		= TextFieldAutoSize.LEFT;		moneylabel.background 	= true;		moneylabel.border 		= true;				moneylabel.x = xy.x;		moneylabel.y = xy.y;				var format:TextFormat = new TextFormat();		format.font 		  = "Comic Sans MS";		format.color 		  = 0xFF0000;		format.size 		  = 10;		format.underline 	  = false;				moneylabel.defaultTextFormat = format;			addChild(moneylabel);		dboard.addChild( this );	}		public function update( money:Number ){		moneylabel.text = '$'+ money.toString( );	}}class HealthBox extends Sprite{	private var healthlabel:TextField;		public function HealthBox( dboard:DashBoard, xy:Point ){		healthlabel 				= new TextField();		healthlabel.autoSize		= TextFieldAutoSize.LEFT;		healthlabel.background 	= true;		healthlabel.border 		= true;				healthlabel.x = xy.x;		healthlabel.y = xy.y;				var format:TextFormat = new TextFormat();		format.font 		  = "Comic Sans MS";		format.color 		  = 0x000099;		format.size 		  = 10;		format.underline 	  = false;				healthlabel.defaultTextFormat = format;			addChild(healthlabel);		dboard.addChild( this );	}		public function update( health:Number ){		if( health <= 0 ){			healthlabel.text = 'Game Over';		}else if( health > Player.MAXHEALTH ){	// a temp hack to display win.			healthlabel.text = 'Congrats! You Won!'		}else{			healthlabel.text = 'Life: '+ health.toString( );		}	}		}class WaveBox extends Sprite{	private var wavelabel:TextField;		public function WaveBox( dboard:DashBoard, xy:Point ){		wavelabel 				= new TextField();		wavelabel.autoSize		= TextFieldAutoSize.LEFT;		wavelabel.background 	= true;		wavelabel.border 		= true;				wavelabel.x = xy.x;		wavelabel.y = xy.y;				var format:TextFormat = new TextFormat();		format.font 		  = "Comic Sans MS";		format.color 		  = 0xCC0066;		format.size 		  = 10;		format.underline 	  = false;				wavelabel.defaultTextFormat = format;			addChild(wavelabel);		dboard.addChild( this );		update( Waves.MAXWAVES );	}		public function update( wave:Number ){		if( wave == 1 ){			wavelabel.text = "!Final Weawave!"		}else{			wavelabel.text = wave.toString( ) + " weawaves left"		}	}		}class RestartButton extends Sprite{	private var btn:Button;	private var dboard:DashBoard;		public function RestartButton( l_dboard:DashBoard, xy:Point ){		dboard 	 = l_dboard;		btn 	 = new Button( );				btn.x = xy.x;		btn.y = xy.y		btn.label  = "New Game";		btn.setStyle( "textFormat", new TextFormat( "Comic Sans MS")) ;		btn.addEventListener( MouseEvent.CLICK, restart, false, 0, true );		addChild(btn);		dboard.addChild(this);	}		private function restart( eve:MouseEvent ){		dboard.game.restart( );	}}