package Skeleton.sagent
{
	import Skeleton.sagent.states.ChaseStateS;
	import Skeleton.sagent.states.ConfusionStateS;
	import Skeleton.sagent.states.FleeStateS;
	import Skeleton.sagent.states.IAgentStateS;
	import Skeleton.sagent.states.IdleStateS;
	import Skeleton.sagent.states.WanderStateS;
	import Skeleton.sagent.states.ShootStateS;
	import Skeleton.sagent.states.AttackStateS;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import flash.display.MovieClip;
	public class AgentS extends Sprite
	{
		public static const IDLE:IAgentStateS = new IdleStateS(); //Define possible states as static constants
		public static const WANDER:IAgentStateS = new WanderStateS();
		public static const CHASE:IAgentStateS = new ChaseStateS();
		public static const FLEE:IAgentStateS = new FleeStateS();
		public static const CONFUSED:IAgentStateS = new ConfusionStateS();
		public static const ATTACK:IAgentStateS = new AttackStateS();
		public static const SHOOT:IAgentStateS = new ShootStateS();
		
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _previousState:IAgentStateS; //The previous executing state
		private var _currentState:IAgentStateS; //The currently executing state
		private var _pointer:Shape;
		private var _tf:TextField;
		public var velocity:Point = new Point();
		public var speed:Number = 0; //setting base speed of the agents
		
		public var fleeRadius:Number = 100; //If the mouse is "seen" within this radius, we want to flee
		public var chaseRadius:Number = 385; //If the mouse is "seen" within this radius, we want to chase
		public var meleeRadius:Number = 30;//If the mouse is "seen" within this radius, we turn and fight
		public var shootRadius:Number = 190;
		public var numCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		
		public var skeleton = new Skeleton();
		
		public var health:Number;
		public var armor:Number;
		public var shootAttack:Number;
		public var stabAttack:Number;
		
		public var starget:MovieClip;
		public var shoot:Boolean;
		public var stab:Boolean;
		public var bowCounter:int = 0;
		public var stabCounter:int = 0;
		
		public function AgentS() 
		{
			//Boring stuff here
			_tf = new TextField();
			_tf.defaultTextFormat = new TextFormat("_sans", 10);
			_tf.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(skeleton);
			addChild(_tf);
			graphics.lineStyle(0, 0xFF0000, 1);
			graphics.drawCircle(0, 0, fleeRadius);
			graphics.lineStyle(0, 0x00FF00,1);
			graphics.drawCircle(0, 0, chaseRadius);
			graphics.lineStyle(0, 0xF0000F, 1);
			graphics.drawCircle(0, 0, shootRadius);
			graphics.lineStyle(0, 0xF0000F, 1);
			graphics.drawCircle(0, 0, meleeRadius);
			
			_currentState = IDLE; //Set the initial state
			
			health = Math.ceil(Math.random() * 50 + 50);
			armor = 1;
			shootAttack = 10;
			stabAttack = 8;
			
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
			var dot:Number = starget.x * velocity.x + starget.y * velocity.y; //seting the specific position of the mouse
			return dot > 0;
		}
		public function get distanceToMouse():Number {
			var dx:Number = x - starget.x;
			var dy:Number = y - starget.y;
			return Math.sqrt(dx * dx + dy * dy); //code to locate the mouse
		}
		
		public function randomDirection():void {
			var s:Number = Math.random() * 6.28;
			velocity.x = Math.cos(s);
			velocity.y = Math.sin(s);
		}
		public function faceMouse(multiplier:Number = 1):void {
			var dx:Number = starget.x - x;
			var dy:Number = starget.y - y;
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
			if (y + velocity.y > stage.stageHeight || y + velocity.y < 0) {
				y = Math.max(0, Math.min(stage.stageHeight, y));
				velocity.y *= -1;
			}
			skeleton.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
			
			if (_currentState == SHOOT){
				shoot = false;
				bowCounter++
				if (bowCounter ==30){
					trace ("pew!");
					shoot = true;
					bowCounter = 0;
				}
			}
			if (_currentState == ATTACK){
				stab = false;
				stabCounter++
				if (stabCounter ==30){
					trace ("stab");
					stab = true;
					stabCounter = 0;
				}
			}
		}
		public function setState(newState:IAgentStateS):void {
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_previousState = _currentState;
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}
		
		public function get previousState():IAgentStateS { return _previousState; }
		
		public function get currentState():IAgentStateS { return _currentState; }
		
	}

}