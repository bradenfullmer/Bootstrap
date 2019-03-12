package lib.charge {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.KeyboardEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	//importing the different libraries to use for the game

	public class MyChargeGame extends MovieClip {
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< DEFINING ALL OF MY VARIABLE USED WITHIN THE GAME
		private var currentStage: MovieClip;

		private var enemyBase: MovieClip;
		private var heroBase: MovieClip;

		private var enemyHealth: MovieClip;
		private var heroHealth: MovieClip;

		private var enemyCounter: Number;
		private var enemyCounterTotal: Number;

		private var archerCounter: Number;
		private var archerCounterTotal: Number;

		private var warriorCounter: Number;
		private var warriorCounterTotal: Number;

		private var heroGuys: Array;
		private var enemyGuys: Array;

		private var ArcherButton: SimpleButton;
		private var WarriorButton: SimpleButton;

		private var yBuffer: Number;
		private var xBuffer: Number;


		public var heroScore: Number;
		public var enemyScore: Number;

		private var yourField: TextField;
		private var enemyField: TextField;

		private var endScreen: MovieClip;
		private var winScreen: MovieClip;

		private var archer: Boolean;
		private var warrior: Boolean;

		//creating the private variables for different parts of the game

		public function MyChargeGame() {
			//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< THIS CODE IS ADDING THE MAIN STAGE AND PLAYING FIELD, THE BUTTONS, THE SCORE, THE CASTLES, AND THE HEALTH BARS
			yBuffer = 100;
			xBuffer = 50;

			archer = false;
			warrior = false;

			archerCounter = 100;
			warriorCounter = 100;
			enemyCounter = 80;
			enemyCounterTotal = 100;
			archerCounterTotal = 80;
			warriorCounterTotal = 80;


			heroGuys = new Array();
			enemyGuys = new Array();

			currentStage = new Stage1();

			ArcherButton = new archerButton();
			WarriorButton = new warriorButton();

			WarriorButton.x = ArcherButton.width;

			addChild(currentStage);
			addChild(ArcherButton);
			addChild(WarriorButton);


			heroScore = 0;
			enemyScore = 0;

			yourField = new TextField;
			yourField.width = 200;
			yourField.text = "Your Score: 0";
			enemyField = new TextField;
			enemyField.width = 200;
			enemyField.text = "Enemy Score: 0";

			yourField.x = ArcherButton.width + WarriorButton.width;
			enemyField.x = yourField.x + yourField.width;
			

			addChild(yourField);
			addChild(enemyField);

			ArcherButton.addEventListener(MouseEvent.CLICK, createArcherHandler);
			WarriorButton.addEventListener(MouseEvent.CLICK, createWarriorHandler);

			heroBase = new heroCastle();
			enemyBase = new enemyCastle();

			heroBase.y = -116.2;
			heroBase.x = 200;
			enemyBase.y = -106.2;
			enemyBase.x = 2161.1;

			currentStage.playingField.addChild(heroBase);
			currentStage.playingField.addChild(enemyBase);

			enemyHealth = new healthBar();
			heroHealth = new healthBar();

			heroHealth.y = 20;
			heroHealth.x = 160;

			enemyHealth.y = 20;
			enemyHealth.x = 365;

			addChild(heroHealth);
			addChild(enemyHealth);

			addEventListener(Event.ENTER_FRAME, update);
		}
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< THIS IS THE CODE FOR CREATING THE HERO GUYS FROM THE BUTTONS
		private function createArcherHandler(evt: MouseEvent): void {
			archer = true;
			createGuy("Right", new heroArcher());
		}

		private function createWarriorHandler(evt: MouseEvent): void {
			warrior = true;
			createGuy("Right", new heroWarrior());
		}

		private function createGuy(dir: String, newGuy: MyGuy): void {
			trace("guy created! " + dir);

			newGuy.setDir(dir);

			newGuy.y = heroBase.y + heroBase.height - newGuy.height;

			if (dir == "Right") {
				trace(archer);
				trace(warrior);
				if (archer == true) {
					ArcherButton.mouseEnabled = false;
					ArcherButton.alpha = 0.5;
					archerCounter = 0;
					archer = false;
				}
			}
			if (warrior == true) {
				WarriorButton.mouseEnabled = false;
				WarriorButton.alpha = 0.5;
				warriorCounter = 0;
				warrior = false;
			}

			newGuy.x = 490;
			newGuy.y = 95;

			
			//trace(newGuy.enemies.length);

			heroGuys.push(newGuy);
			trace(heroGuys.length);
			currentStage.playingField.addChild(newGuy);
			
		}
		private function createEnemies(newGuy: EnemyGuys): void {
			trace(enemyGuys.length);

			newGuy.x = 2000;
			newGuy.y = 95

			

			enemyGuys.push(newGuy);
			currentStage.playingField.addChild(newGuy);
			
		}




		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< THIS IS THE SPAWNING FOR THE ENEMY GUYS
		private function update(evt: Event): void {
			if (archerCounter < archerCounterTotal) {
				archerCounter++;
			} else {
				ArcherButton.mouseEnabled = true;
				ArcherButton.alpha = 1;
				archer = false;
			}
			if (warriorCounter < warriorCounterTotal) {
				warriorCounter++;
			} else {
				WarriorButton.mouseEnabled = true;
				WarriorButton.alpha = 1;
				warrior = false;
			}
			if (enemyCounter < enemyCounterTotal) {
				enemyCounter++;
			} else {
				enemyCounter = -100;
				createEnemies (new enemyArcher);
				//trace("help");
				//createGuy("Left", new enemyArcher);
				//var newGuy:enemyWarrior = new enemyWarrior();
				//newGuy.setDir("Left");
				//newGuy.x = 2000;
				//newGuy.y = 95;
				//newGuy.enemies = heroGuys;
				//newGuy.friend = enemyGuys;
				//enemyGuys.push(newGuy);
				//currentStage.playingField.addChild(newGuy);
			}
			if (enemyCounter < enemyCounterTotal) {
				enemyCounter++;
			} else {
				enemyCounter = -100;
				createEnemies (new enemyWarrior);
				//createGuy("Left", new enemyWarrior);
			}

			currentStage.update();

			var guy;

			//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< THIS IS THE PLAYER COLLISION PHYSICS SOLVE CODE
			for each(guy in enemyGuys) {
				guy.enemies = heroGuys;
				guy.friends = enemyGuys;
				if (guy.hitTestObject(heroBase)) {
					heroHealth.width -= 5;
					trace(heroHealth.width);
					guy.purge();
				} else {
					guy.update();
				}
			}
			for each(guy in heroGuys) {
				guy.enemies = enemyGuys;
				guy.friends = heroGuys;
				if (guy.hitTestObject(enemyBase)) {
					enemyHealth.width -= 5;
					guy.purge();
				} else {
					guy.update();
				}
			}
			//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< THIS IS THE SCORING CODE THAT NEEDS TO BE FIXED
			for each(guy in enemyGuys) {
				if (guy.status == "Die") {
					heroScore = 5;
					yourField.text = "Your Score: " + heroScore;
					guy.die();
				}
			}
			for each(guy in heroGuys) {
				if (guy.status == "Die") {
					enemyScore = 5;
					enemyField.text = "Enemy Score: " + enemyScore;
					guy.die();
				}
			}

			//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< THIS IS THE ENDING SCREENS CODE WITH THE GREENSOCK CODE
			if (heroHealth.width <= 5) {
				TweenPlugin.activate([TintPlugin]);
				TweenLite.to(currentStage, 5, {
					alpha: 0.65,
					tint: 0xcc0000,
					ease: Back.easeOut
				});

				pause(5000, function (e: Event) {
					loseGame();
				});
			}
			if (enemyHealth.width <= 5) {
				TweenPlugin.activate([TintPlugin]);
				TweenLite.to(currentStage, 5, {
					alpha: 0.65,
					tint: 0x33ccff,
					ease: Back.easeOut
				});

				pause(5000, function (e: Event) {
					winGame();
				});
			}

			function pause(delay: int, func: Function): void {
				var timer: Timer = new Timer(delay, 1);
				timer.addEventListener(TimerEvent.TIMER, func);
				timer.start();

			}

			function unpause(): void {

			}
			function winGame(): void {
				removeEventListener(Event.ENTER_FRAME, update);

				var i: int = stage.numChildren;
				trace(i);
				while (i--) {
					removeChildAt(i);
				}
				winScreen = new WinScreen();
				addChild(winScreen);
				createWinMenu();

			}

			function loseGame(): void {

				removeEventListener(Event.ENTER_FRAME, update);

				var i: int = stage.numChildren;

				trace(i);
				while (i--) {

					removeChildAt(i);
				}
				endScreen = new EndScreen();
				addChild(endScreen);
				createEndMenu();
			}
			//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< THIS IS THE CODE THAT MAKES THE GAME RESTART WHEN PLAYER WINS OR LOSES				
			function createEndMenu(): void {
				var endMenu = endScreen

				endMenu.tryAgain.addEventListener(MouseEvent.CLICK, tryAgainHandler);
			}

			function tryAgainHandler(evt: MouseEvent): void {
				removeChild(evt.currentTarget.parent);

				evt.currentTarget.removeEventListener(MouseEvent.CLICK, tryAgainHandler);

				reCreateGame();
			}


			function createWinMenu(): void {
				var winMenu = winScreen

				winMenu.reStart.addEventListener(MouseEvent.CLICK, restartGameHandler);
			}

			function restartGameHandler(evt: MouseEvent): void {
				removeChild(evt.currentTarget.parent);

				evt.currentTarget.removeEventListener(MouseEvent.CLICK, restartGameHandler);

				reCreateGame();
			}

			function reCreateGame(): void {
				var game: MyChargeGame = new MyChargeGame();

				addChild(game);
			}

		}
	}
}