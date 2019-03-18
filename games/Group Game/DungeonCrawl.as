package {
	import Zombie.zagent.ZAgent;
    //import Skeleton.sagent.AgentS;
    import Wizard.wagent.AgentW;
	import Maze.Walls;
	import Maze.Floors;
	import Maze.Stairs;
	
	

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.Shape;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.text.*;
	import flash.geom.Point;
	import flash.display.StageAlign;
	import SnakeCode.Segment;
	

	public class DungeonCrawl extends MovieClip {
		private var floor: Sprite;
		private var walls: MovieClip;
		private var wallArray:Array;
		private var stairs:MovieClip;
		public var collisionLayer: Sprite;
		private var touchLayer: Sprite;

		private var player: Player;
		private var player2: Player2;
		private var obstacle: Rectangle;
		private var _previousX: int;
		private var _previousY: int;
		private var moveSpeed: Number = 5;
		public var health:Number;
		public var swordDamage:Number = 10 ;
		private var startX:int;
		private var startY:int;
		private var endscreen: MovieClip;

		public var healthbar = new HealthBar1();
		private var goldField = new GoldCounter();
		//private var goldTextLocation: Point;
		
		private var addGold: uint;

		private var swordButton: SimpleButton;
		private var bowButton: SimpleButton;
		
		public var sword1 = new Sword();
		public var sword2 = new Sword();
		public var sword3 = new Sword();
		public var sword4 = new Sword();
				
		private var agents:Vector.<ZAgent>;
         
        //private var sagents:Vector.<AgentS>;
         
        private var wagents:Vector.<AgentW>;
         
		private var a:ZAgent = new ZAgent();
		
		private var segment: Segment;
		private var color: uint;
		private var segmentWidth: Number;
		private var segmentHeight: Number;
		private var cycle: Number = 0;
		private var objectLayer: Sprite = new Sprite();
		private var larrylayer: Sprite = new Sprite();
		private var Tail: tail;

		private var Larry: larry;


		public var vx: Number = 5;
		public var vy: Number = 5;
		
		
		public function DungeonCrawl() {


			swordButton = new Sword_btn();
			bowButton = new Bow_btn();


			swordButton.x = 10;
			swordButton.y = 800;
			bowButton.x = 10;
			bowButton.y = 700;

			player = new Player();

			//=== NEW   MAP  CODE ===
			/*
				0. walls
				1. floors
				2. entrance stairs
				3. exit stairs
			*/
				floor = new Floors("Level1");
				addChild(floor);
				walls= new Walls("Level1");
				addChild(walls);
				stairs = new Stairs("Level1");
			//player.x = stairs.startPlayerX;
			//player.y = stairs.startPlayerY;
				addChild(stairs);
			//=== END NEW MAP CODE===

			player.x = 481;
			player.y = 881;
			
			trace(x,y);
			player2 = new Player2();
			addChild(player);
			
		
			//goldTextLocation = new Point(0, 1100);
			
			
			
			goldField.width = 200;
			
			goldField.x = 0;
			goldField.y = 900;
			
			addGold = 0;
			trace(addGold);
			
			trace("GOOOOOOOOLD", goldField.x, goldField.y);
			addChild(goldField);
			goldField.textColor = 0xFF8408;
			
			
			

			
			addChild(healthbar);
			healthbar.y = 1100;
				
				if(healthbar.length<5) {
					gameOver();
				}
		
	
			addEventListener(Event.ENTER_FRAME, update);

			collisionLayer = new Sprite();
			addChild(collisionLayer);
			addEventListener(Event.ADDED_TO_STAGE, setupCollisionLayer);

			touchLayer = new Sprite();
			addChild(touchLayer);
			addEventListener(Event.ADDED_TO_STAGE, setupTouchLayer);




			var AudioPlayer: SoundChannel = new SoundChannel();
			var sndFile: Sound = new Music();
			AudioPlayer = sndFile.play();



			addChild(swordButton);
			addChild(bowButton);


			swordButton.addEventListener(MouseEvent.CLICK, createSwordHandler);
			bowButton.addEventListener(MouseEvent.CLICK, createBowHandler);
			addEventListener(MouseEvent.CLICK, playerAttack);
			if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
			
			

		}
		
		private function init(e:Event = null):void
        {
             
            removeEventListener(Event.ADDED_TO_STAGE, init);
            agents = new Vector.<ZAgent>();
            addEventListener(Event.ENTER_FRAME, gameloop);
            for (var i:int = 0; i < 10; i++) 
            {
                var a:ZAgent = new ZAgent();
                addChild(a);
                agents.push(a);
				if (i == 0){
                a.x = 225
                a.y = 480
				}
				if (i == 1){
					a.x = 150
					a.y = 200
				}
				if (i == 2){
					a.x = 225
					a.y = 100
				}
				if (i == 3){
					a.x = 300
					a.y = 276
				}
				if (i == 4){
					a.x = 725
					a.y = 200
				}
				if (i == 5){
					a.x = 789
					a.y = 235
				}
				if (i == 6){
					a.x = 179
					a.y = 785
				}
				if (i == 7){
					a.x = 625
					a.y = 257
				}
				if (i == 8){
					a.x = 825
					a.y = 150
				}
				if (i == 9){
					a.x = 276
					a.y = 625
					
				}
            }
            /*sagents = new Vector.<AgentS>();
            for (var j:int = 0; j < 1; j++) 
            {
                var s:AgentS = new AgentS();
                addChild(s);
                sagents.push(s);
                s.x = 350
                s.y = 100
            }*/
            wagents = new Vector.<AgentW>();
            for (var k:int = 0; k < 1; k++) 
            {
                var w:AgentW = new AgentW();
                addChild(w);
                wagents.push(w);
                w.x = 710
                w.y = 545
            }
			
			var objectLayer = new Sprite();
			this.addChild(objectLayer);
			var larrylayer = new Sprite();
			this.addChild(larrylayer);

			segment = new Segment(30, 10);

			var Tail: MovieClip = new tail as MovieClip;


			var Larry: MovieClip = new larry as MovieClip;
			larrylayer.addChild(Larry);
			Larry.x = 650;
			Larry.y = 960;


			objectLayer.addChild(segment);
			segment.addChild(Tail);
			segment.x = Larry.x;
			segment.y = Larry.y;

        }



		private function createSwordHandler(evt: MouseEvent): void {
			player.x = player2.x;
			player.y = player2.y;
			removeChild(player2);
			addChild(player);
		}

		private function createBowHandler(evt: MouseEvent): void {
			player2.x = player.x;
			player2.y = player.y;
			removeChild(player);
			addChild(player2);
		}
		
		private function playerAttack(evt:MouseEvent):void {
			for (var a:int = 0; a < agents.length; a++) 
			
            {
				if(player.currentFrame == 1) {
					player.sword1.gotoAndPlay(2);
					if (player.sword1.hitTestObject(agents[a])){
						trace("HIT",agents.length);
						removeChild(agents[a])
						addChild(agents[a])
						agents[a].x = -100
						agents[a].y = -100
						addGold += 5;
						trace(                             addGold);
					}
				}
				else if (player.currentFrame == 5) {
					player.sword2.gotoAndPlay(2);
					if (player.sword2.hitTestObject(agents[a])){
						trace("HIT",agents.length);
						removeChild(agents[a])
						addChild(agents[a])
						agents[a].x = -100
						agents[a].y = -100
						addGold += 5;
						trace(                             addGold);
					}
				}
				else if (player.currentFrame == 10) {
					player.sword3.gotoAndPlay(2);
					if (player.sword3.hitTestObject(agents[a])){
						trace("HIT", agents.length);
						removeChild(agents[a])
						addChild(agents[a])
						agents[a].x = -100
						agents[a].y = -100
						addGold += 5;
						trace(                             addGold);
					}
				}
				else if (player.currentFrame == 15) {
					player.sword4.gotoAndPlay(2);
					if (player.sword4.hitTestObject(agents[a])){
						trace("HIT", agents.length);
						removeChild(agents[a])
						addChild(agents[a])
						agents[a].x = -100
						agents[a].y = -100
						addGold += 5;
						trace(                             addGold);
					}
				}
			}
		}


		private function setupCollisionLayer(evt: Event): void {
			collisionLayer.graphics.beginFill(0x000000, 0);
			collisionLayer.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			collisionLayer.graphics.endFill();

		}

		private function setupTouchLayer(evt: Event): void {
			touchLayer.graphics.beginFill(0x000000, 0);
			touchLayer.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			touchLayer.graphics.endFill();

			//player.x = 520;
			//player.y = 925;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				//add key up handler
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
	}
		private function keyDownHandler(evt: KeyboardEvent): void {
			//trace(evt.keyCode);

			//87=w 68=d 83=s 65=a
			if (evt.keyCode == 87) {
				player.directionY = "up";
				player.y -= moveSpeed;
				player2.y -= moveSpeed;
				//compileBow.y -= moveSpeed;
				//compileSword.y -= moveSpeed;
				player.gotoAndStop(10);
				player2.gotoAndStop(10);
			} else if (evt.keyCode == 83) {
				player.directionY = "down";
				player.y += moveSpeed;
				player2.y += moveSpeed;
				//compileBow.y += moveSpeed;
				//compileSword.y += moveSpeed;
				player.gotoAndStop(15);
				player2.gotoAndStop(15);
			} else if (evt.keyCode == 68) {
				player.directionX = "right";
				player.x += moveSpeed;
				player2.x += moveSpeed;
				//compileBow.x += moveSpeed;
				//compileSword.x += moveSpeed;
				player.gotoAndStop(1);
				player2.gotoAndStop(1);
			} else if (evt.keyCode == 65) {
				player.directionX = "left";
				player.x -= moveSpeed;
				player2.x -= moveSpeed;
				//compileBow.x -= moveSpeed;
				//compileSword.x -= moveSpeed;
				player.gotoAndStop(5);
				player2.gotoAndStop(5);
				
				
				
			}
			//trace(player.x, player.y);
			//trace(player.currentFrame);
			//trace(player.directionX, player.directionY);
		}
			
//===KEY UP HANDLER===
		private function keyUpHandler(e:KeyboardEvent):void{
			if (e.keyCode==87 || e.keyCode == 83)
			{
				player.directionY=""
			}
			if (e.keyCode==68 || e.keyCode == 65)
			{
				player.directionX=""
			}
			
		}
//===END KEY UP HANDLER===


		

		private function update(evt: Event): void {

		}
		 private function gameloop(e:Event):void
        {
			walk(segment, cycle);
			cycle += .05;
            for (var i:int = 0; i < agents.length; i++) 
            {
                agents[i].update();
                agents[i].ztarget = player;
                if (agents[i].biting == true){
                    healthbar.width -= 4; 
				if(healthbar.width < 10){
					gameOver();
					}
                // if player.hitTestObject(agents[i]) and agents[i].biting is true
                // then health sutract
                }
            }
			goldField.goldText.text = "Gold Count: " + String(addGold);
 
 			//=========Wall Collision===========
			
			for each (var we:wall_Element in walls.bumpArray)
			{
				if(player.hitTestObject(we))
				{
					//trace(player.directionX + ", " + player.directionY)
					//check direction, stop that direction.
					if (player.directionX=="left")
					{
						player.x += moveSpeed;
					}
					else if (player.directionX=="right")
					{
						player.x -= moveSpeed;
					}
					
					if (player.directionY == "up")
					{
						player.y += moveSpeed;
					}
					else if(player.directionY == "down")
					{
						player.y -= moveSpeed;
					}
				}
				
				//wizards
				for each (var wa:AgentW in wagents)
				{
					
					var distToWall:Number = wa.distanceToWall(we);
					//trace(wa.currentState);
					if (wa.currentState != AgentW.AWAY)
					{
						if(distToWall < wa.wallRadius)
						{
							//trace(we.name, distToWall);
							wa.setState(AgentW.AWAY);
							//trace("Away");
							wa.turnAway(we);
						}
						
					}
				}
				//zombies
			for each (var za:ZAgent in agents)
				{
					
					var zDistToWall:Number = za.distanceToWall(we);
					//trace(wa.currentState);
//					if (za.currentState != ZAgent.AWAY)
	//				{
						if(zDistToWall < za.wallRadius)
						{
							//trace(we.name, zDistToWall);
							za.setState(ZAgent.AWAY);
							//trace("Away");
							za.turnAway(we);
						}
						
					//}
				}
					//anything else
			

		}
//===END MONSTER COLLISION===
		
            for (var k:int = 0; k < agents.length; k++) 
            {
                wagents[k].update();
                wagents[k].wtarget = player;
                if (wagents[k].shooting == true){
                    healthbar.width -= 8;
				if(healthbar.width < 10){
					gameOver();
				}
                }
            }
             
        }
         
        public function BiteDamage(a:ZAgent):void{
            healthbar.width -= 5;
        }
		
		private function remove():void {
			removeChildren();
			removeEventListener(Event.ENTER_FRAME, update);
			
		}
		
		private function gameOver():void {
			remove();
			var endScreen: EndScreen = new EndScreen();
			addChild(endScreen);
			endScreen._again.addEventListener(MouseEvent.CLICK, startAgainHandler);
		}
		 private function startAgainHandler(evt: MouseEvent): void {
            removeChild(evt.currentTarget.parent);
 
            evt.currentTarget.removeEventListener(MouseEvent.CLICK, startAgainHandler);
 
            playAgain();
		 }
		 private function playAgain(): void {
            var game: DungeonCrawl = new DungeonCrawl();
 
            addChild(game);
        }
		private function walk(segA: Segment, cyc: Number): void {
			var angleA: Number = Math.sin(cyc) * 40 + 270;
			segA.rotation = angleA;
		}
		private function getPin(): Point {
			var angle: Number = rotation * Math.PI / 90;
			var xPos: Number = x + Math.cos(angle) * segmentWidth;
			var yPos: Number = y + Math.sin(angle) * segmentWidth;
			return new Point(xPos, yPos);
		}
	}
}