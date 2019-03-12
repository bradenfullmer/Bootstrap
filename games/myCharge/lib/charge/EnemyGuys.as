package lib.charge {
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;

	public class EnemyGuys extends MyGuy {
		private var dir: String;
		private var curFrame: Number;
		private var attackFrames: Number;
		private var hitFrame: Number;
		private var target: MyGuy;

		public function EnemyGuys() {
			enemies = new Array();
			//set the defaul conditions for a generic guy
			dir = "Left";
			setStatus("Walk");

			curFrame = 0;
			attackFrames = 8;
			hitFrame = 5;

			//Randomize health, speed, and damage  
			health = Math.ceil(Math.random() * 50 + 75);
			damage = Math.ceil(Math.random() * 10 + 5);
			speed = -(Math.random() * 2 + 2);
			// constructor code

		}
		
		override public function setDir(newDir: String): void {
			dir = newDir;
			gotoAndStop(status + "Left");
		}

		override public function setStatus(state: String): void {
			status = state;
			gotoAndStop(status + "Left");
		}

		override public function getStatus(): String {
			return status;
		}
		

		override public function attack(): void {
			
			target.takeDamage(damage);
			setStatus("Fight");
			trace("                      attacked");

			if (target.getStatus() == "Die") {
				setStatus("Walk");
				gotoAndStop(status + "Left");
				
			}
		}
		override public function die():void
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
		override public function callPurge(e:TimerEvent) {
			purge();
		}
		override public function purge():void
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
		override public function setTarget(newTarget:MyGuy):void {
			target = newTarget; 
			setStatus("Fight"); 
		}
		override public function lookForTarget(): void {
			for each(var enemy in enemies) {
				if (enemy.getStatus() != "Die" && (dir == "Left" && hitTestObject(enemy))) {
					setTarget(enemy);
					//target = enemy; 
					break;
				}
			}
		}
		override public function update():void
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
				if (dir == "Left")
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
				trace(curFrame, hitFrame); 
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
		