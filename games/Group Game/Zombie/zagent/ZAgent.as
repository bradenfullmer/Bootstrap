package Zombie.zagent
{
	import Zombie.zagent.states.ZChaseState;
	import Zombie.zagent.states.ZConfusionState;
	import Zombie.zagent.states.ZAttackState;
	import Zombie.zagent.states.IAgentStateZ;
	import Zombie.zagent.states.ZIdleState;
	import Zombie.zagent.states.ZWanderState;
	import Zombie.zagent.states.IAgentAttackZ;
	import Zombie.zagent.states.AwayFromWallZ;	
	
	import DungeonCrawl;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import flash.display.MovieClip;
	public class ZAgent extends Sprite
	{
		public static const IDLE:IAgentStateZ = new ZIdleState(); //Define possible states as static constants
		public static const WANDER:IAgentStateZ = new ZWanderState();
		public static const CHASE:IAgentStateZ = new ZChaseState();
		public static const ATTACK:IAgentStateZ = new ZAttackState();
		public static const CONFUSED:IAgentStateZ = new ZConfusionState();
		public static const AWAY:IAgentStateZ = new AwayFromWallZ();
		
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _previousState:IAgentStateZ; //The previous executing state
		private var _currentState:IAgentStateZ; //The currently executing state
		private var _tf:TextField;
		public var velocity:Point = new Point();
		public var speed:Number = 0; //setting base speed of the agents
		
		public var AttackRadius:Number = 15; //If the mouse is "seen" within this radius, we want to flee
		public var wallRadius:Number = 100;
		public var chaseRadius:Number = 195; //If the mouse is "seen" within this radius, we want to chase
		public var numCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		
		
		public var zombie = new Zombie();
		public var health:Number;
		public var armor:Number;
		public var biteAttack:Number;
		
		public var biteCounter:int = 6;
		
		public var ztarget:MovieClip;
		public var biting:Boolean;
		
		public function ZAgent() 
		{
			//Boring stuff here
			_tf = new TextField();
			_tf.defaultTextFormat = new TextFormat("_sans", 10);
			_tf.autoSize = TextFieldAutoSize.LEFT;

			addChild(zombie);
			addChild(_tf);
			
			
			
			_currentState = IDLE; //Set the initial state
			
			health = Math.ceil(Math.random() * 50 + 50);
			biteAttack = 10;
			biting = false;
		}
		/**
		 * Outputs a line of text above the agent's head
		 * @param	str
		 */
		public function say(str:String):void {
			_tf.text = str;
			_tf.y = -_tf.height - 2;
		}
			
		/**
		 * Trig utility methods
		 */
		public function get canSeeMouse():Boolean {
			var dot:Number = ztarget.x * velocity.x + ztarget.y * velocity.y; //seting the specific position of the mouse
			return dot > 0;
		}
		public function get distanceToMouse():Number {
			var dx:Number = x - ztarget.x;
			var dy:Number = y - ztarget.y;
			return Math.sqrt(dx * dx + dy * dy); //code to locate the mouse
		}

		
		//=========start wall collision============
		public function distanceToWall(wallTarget:wall_Element):Number {
			var dx:Number = x - wallTarget.x+wallTarget.width/2;
			var dy:Number = y - wallTarget.y+wallTarget.height/2;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public function turnAway(we:wall_Element):void{
			if (we.x<x)
			{
				velocity.x+=speed;
			}
			else{
				velocity.x-=speed;
			}
			if(we.y<y)
			{
				velocity.y+=speed;
			}
			else{
				velocity.y-=speed;
			}
		}
		//============end wall collision===========

		public function randomDirection():void {
			var a:Number = Math.random() * 6.28;
			velocity.x = Math.cos(a);
			velocity.y = Math.sin(a);
		}
		public function faceMouse(multiplier:Number = 1):void {
			var dx:Number = ztarget.x - x;
			var dy:Number = ztarget.y - y;
			var rad:Number = Math.atan2(dy, dx);
			velocity.x = multiplier*Math.cos(rad);
			velocity.y = multiplier*Math.sin(rad);
		}
		
		/**
		 * Update the current state, then update the graphics
		 */
		public function update():void {
			if (!_currentState) return; //If there's no behavior, we do nothing
			numCycles++; 
			_currentState.update(this);
			x += velocity.x*speed;
			y += velocity.y*speed;
			if (x + velocity.x > stage.stageWidth || x + velocity.x < 0) {
				x = Math.max(0, Math.min(stage.stageWidth, x));
				velocity.x *= -1;
			}
			if(velocity.x < 0 && velocity.x < velocity.y) {
				zombie.gotoAndStop(1)
				//trace(zombie.currentFrame)
			}1
			if(velocity.x > 0 && velocity.x > velocity.y) {
				zombie.gotoAndStop(3)
				//trace(zombie.currentFrame)
			}
			if(velocity.y < 0 && velocity.y < velocity.x) {
				zombie.gotoAndStop(4)
				//trace(zombie.currentFrame)
			}
			if(velocity.y > 0 && velocity.y > velocity.x) {
				zombie.gotoAndStop(2)
				//trace(zombie.currentFrame)
			}
			

			if (y + velocity.y > stage.stageHeight || y + velocity.y < 0) {
				y = Math.max(0, Math.min(stage.stageHeight, y));
				velocity.y *= -1;
			}
			//zombie.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
			
			if (_currentState == ATTACK){
				biting = false;
				biteCounter++
				if (biteCounter ==12){
					trace ("Bite");
					biting = true;
					biteCounter = 0;
				}
			}
		}
		public function setState(newState:IAgentStateZ):void {
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_previousState = _currentState;
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}
		
		public function get previousState():IAgentStateZ { return _previousState; }
		
		public function get currentState():IAgentStateZ { return _currentState; }
				
	}

}
