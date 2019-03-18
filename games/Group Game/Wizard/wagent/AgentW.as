package Wizard.wagent
{
	import Wizard.wagent.states.ChaseStateW;
	import Wizard.wagent.states.FleeStateW;
	import Wizard.wagent.states.IAgentStateW;
	import Wizard.wagent.states.IdleStateW;
	import Wizard.wagent.states.WanderStateW;
	import Wizard.wagent.states.ShootStateW;
	import Wizard.wagent.states.AwayFromWallW;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import flash.display.MovieClip;
	public class AgentW extends Sprite
	{
		public static const IDLE:IAgentStateW = new IdleStateW(); //Define possible states as static constants
		public static const WANDER:IAgentStateW = new WanderStateW();
		public static const CHASE:IAgentStateW = new ChaseStateW();
		public static const FLEE:IAgentStateW = new FleeStateW();
		public static const SHOOT:IAgentStateW = new ShootStateW();
		public static const AWAY:IAgentStateW = new AwayFromWallW();
		
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _previousState:IAgentStateW; //The previous executing state
		private var _currentState:IAgentStateW; //The currently executing state
		private var _pointer:Shape;
		private var _tf:TextField;
		public var velocity:Point = new Point();
		public var speed:Number = 0; //setting base speed of the agents
		
		public var fleeRadius:Number = 55; //If the mouse is "seen" within this radius, we want to flee
		public var wallRadius:Number = 100; //if you are this close to a wall, turn and go somewhere else
		public var chaseRadius:Number = 160; //If the mouse is "seen" within this radius, we want to chase
		public var shootRadius:Number = 125;
		public var numCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		
		public var wizard = new Wizard();
		
		public var health:Number;
		public var armor:Number;
		public var shootAttack:Number;
		
		public var shootCounter:int = 8;
		public var wtarget:MovieClip;
		public var shooting:Boolean;
		
		public function AgentW() 
		{
			//Boring stuff here
			_tf = new TextField();
			_tf.defaultTextFormat = new TextFormat("_sans", 10);
			_tf.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(wizard);
			addChild(_tf);

			
			_currentState = IDLE; //Set the initial state
			
			health = Math.ceil(Math.random() * 50 + 50);
			armor = 1.2;
			shootAttack = 10;
			shooting = false;
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
			var dot:Number = wtarget.x * velocity.x + wtarget.y * velocity.y; //seting the specific position of the mouse
			return dot > 0;
		}
		public function get distanceToMouse():Number {
			var dx:Number = x - wtarget.x;
			var dy:Number = y - wtarget.y;
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
			var w:Number = Math.random() * 6.28;
			velocity.x = Math.cos(w);
			velocity.y = Math.sin(w);
		}
		public function faceMouse(multiplier:Number = 1):void {
			var dx:Number = wtarget.x - x;
			var dy:Number = wtarget.y - y;
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
			//wizard.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
			
			if(velocity.x < 0 && velocity.x < velocity.y) {
				wizard.gotoAndStop(2)
				
			}//1
			if(velocity.x > 0 && velocity.x > velocity.y) {
				wizard.gotoAndStop(1)
				
			}
			if(velocity.y < 0 && velocity.y < velocity.x) {
				wizard.gotoAndStop(4)
				
			}
			if(velocity.y > 0 && velocity.y > velocity.x) {
				wizard.gotoAndStop(3)
				
			}
			

			if (y + velocity.y > stage.stageHeight || y + velocity.y < 0) {
				y = Math.max(0, Math.min(stage.stageHeight, y));
				velocity.y *= -1;
			}
			
			
			if (_currentState == SHOOT){
				shooting = false;
				shootCounter++
				if (shootCounter == 15){
					trace ("pew");
					shooting = true;
					shootCounter = 0;
				}
			}
			if (_currentState == FLEE){
				shooting = false;
				shootCounter++
				if (shootCounter == 15){
					trace ("pew");
					shooting = true;
					shootCounter = 0;
				}
			}
			
		}
		public function setState(newState:IAgentStateW):void {
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_previousState = _currentState;
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}
		
		public function get previousState():IAgentStateW { return _previousState; }
		
		public function get currentState():IAgentStateW { return _currentState; }
		
	}

}