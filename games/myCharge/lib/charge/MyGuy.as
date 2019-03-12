package lib.charge
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	
	public class MyGuy extends MovieClip
	{
		public var status:String;
		private var dir:String;
		
		public var health:Number;
		public var damage:Number;
		public var speed:Number;
		
		private var curFrame:Number;
		private var attackFrames:Number;
		private var hitFrame:Number;
		
		private var target:MyGuy;
		
		public var enemies:Array;
		public var friends:Array;
		
		/*private var enemyArcher:Number;
		private var enemyWarrior:Number;
		private var heroArcher:Number;
		private var heroWarrior:Number;*/
		
		/*public var type:Number;
		
		public var graphic:MovieClip;*/
		
		public function MyGuy(/*health:Number, speed:Number, damage:Number, type:Number*/)
		{
			
			enemies = new Array();
			//set the defaul conditions for a generic guy
			dir = "Right";
			setStatus("Walk");
			
			curFrame = 0;
			attackFrames = 8;
			hitFrame = 5;
			
			//Randomize health, speed, and damage  
			health = Math.ceil(Math.random() * 50 + 75);
			damage = Math.ceil(Math.random() * 10 + 5);
			speed = Math.random() * 2 + 2;
			/*enemyArcher = 1; 
			enemyWarrior = 2; 
			heroArcher = 3;
			heroWarrior = 4;
			
			this.health = health;
			this.damage = damage;
			this.speed = speed;
			this.type = type;
			
			if (this.type == 1) {
				this.graphic = enemyArcher;
			}
			if (this.type == 2) {
				this.graphic = enemyWarrior;
			}
			if (this.type == 3) {
				this.graphic = heroArcher;
			}
			if (this.type == 4) {
				this.graphic = heroWarrior;
			}*/
			// try calling the frame label instead of the frame number.
		}
		
		public function setDir(newDir:String):void
		{
			dir = newDir;
			gotoAndStop(status + dir);
		}
		
		public function setStatus(state:String):void
		{
			//trace("Status = " + state);
			
			status = state;
			gotoAndStop(status + dir);
		}
		
		public function getStatus():String
		{
			return status;
		}
		
		public function attack():void
		{
			target.takeDamage(damage);
			
			if (target.getStatus() == "Die")
			{
				setStatus("Walk");
				gotoAndStop(status + dir);
				
			}
			
			curFrame = 0;
		}
		
		public function takeDamage(amount:Number):void
		{
			trace(this + "Took " + amount + " damage!");

			if (status != "Die")
			{
				health -= damage;
				if (health <= 0)
				{
					die();
					
				}
			}
		}
		
		public function die():void
		{
			trace("target died");
			setStatus("Die");
			//trace("Died!");
			health = 0;
			var timer: Timer = new Timer(2000);
				timer.addEventListener(TimerEvent.TIMER, callPurge);
				timer.start();
				//callPurge();
			
		}
		public function callPurge(e:TimerEvent) {
			purge();
		}
		
		public function setTarget(newTarget:MyGuy):void
		{
			target = newTarget;
			setStatus("Fight");
		}
		
		public function lookForTarget():void
		{
			for each(var enemy in enemies)
			{
				if (enemy.getStatus() != "Die" && ((dir == "Right" &&hitTestObject(enemy))))
				{
					setTarget(enemy);
					break;
				}
			}
		}
		
		public function purge():void
		{
			var i:int;
			
				for (i = 0; i < friends.length; i++)
				{
					if (friends[i].name == name)
					{
						friends.splice(i, 1);
						i = friends.length;
					}
				}
				parent.removeChild(this);
			}
			
		
		public function update():void
		{
			//trace(this + " " + status); 
			if (status == "Die")
			{				
				health -= 1;
				if (health <= -60)
				{
					//If/else that runs purge with "Friend" or"Enemy"
					purge();
				}
				else if (health <= -30)
				{
					//blink
					if (alpha == 0)
					{
						alpha = 1;
					}
					else
					{
						alpha = 0;
					}
				}
			}
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< SETS MOVEMENT FOR CHARACTERS IN THEIR DIFFERENT STATES. 			
			else if (status == "Walk")
			{
				if (dir == "Right")
				{
					x += speed;
				}
				else
				{
					x -= speed;
				}
				
				lookForTarget();
			}
			else if (status == "Fight")
			{
				if (curFrame == hitFrame)
				{
					attack();
				}
				curFrame=4;
			}
			else if (status == "Die")
			{
				speed = 0;
				die();
			}
			curFrame++;
		}
	}
}