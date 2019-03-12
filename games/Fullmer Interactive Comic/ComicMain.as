package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.*;
	import flash.ui.Mouse;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	
	
	public class ComicMain extends MovieClip {
		
		private var boarAlive:Boolean;
		private var boarHelped:Boolean;
		
		private var lionAlive:Boolean;
		private var lionHelped:Boolean;
		
		private var dragonAlive:Boolean;
		private var dragonHelped:Boolean;
		
		//Sounds
		private var forest:Forest;
		private var cave:Cave;
		private var swamp:Swamp;
		private var drip:Drip;
		private var backgroundChannel:SoundChannel;
		private var currentSound:String = "";
		private var newSound:String = "";
		
		private const MAIN_THEME:String = "THIS IS THE MAIN THEME";
		private const FOREST_THEME:String = "OLD ASS CREEPY FOREST";
		private const CAVE_THEME:String = "Y'ALL IN THE CAVE NOW";
		private const SWAMP_THEME:String = "WHAT ARE YOU DOING IN MY SWAMP";
		
		//Items that can be obtained and used
		private var havePotion:Boolean; //found in house and used at boar
		private var haveShield:Boolean; //found at corpse and used at lion
		private var haveAmulet:Boolean; //found in room after lion and used at dam
		
		//Text for Pop-up messages
		private const POTION_MSG:String = 'A small vial of viscous liquid. It\'s warm to the touch.';
		private const SHIELD_MSG:String = 'The knight\'s crest saved the metal from the worst of the rust. Weathered, but unbroken.';
		private const AMULET_MSG:String = 'Calm power emanates from the dragon motif amulet. Quiet, but tenacious. The air around it seems cleaner.';
		private const BOAR_MSG:String = 'Ivory tusks cut as deep as any man\'s steel. A potion would be aid you greatly.';
		private const BOAR_EARLY_MSG:String = 'The forest path is blocked by the boar\'s bulk. ';
		private const LION_MSG:String = 'Claws sharper than any blade, something to defend yourself with would be wise.';
		private const STONE_MSG:String = 'Large rocks block the path before you.';
		private const SWAMP_MSG:String = 'The air from the swamp carries a strong and vile stench. Progressing now would be unwise.';
		private const LION_BLOCK_MSG:String = 'The beasts sharp claws swipe toward you when you attempt to slip past.';
		
		
		
		public function ComicMain() {
			// constructor code
			forest = new Forest();
			cave = new Cave();
			swamp = new Swamp();
			drip = new Drip();
			
			backgroundChannel = new SoundChannel();
			
			gotoAndStop('startMenu');
			
			resetValues();
			setUpMouseEvents();
			
			
		}
		
		private function resetValues(){
			boarAlive = true;
			boarHelped = false;
			
			lionAlive = true;
			lionHelped = false;
			
			dragonAlive = true;
			dragonHelped = false;
			
			havePotion = false;
			haveShield = false;
			haveAmulet = false;
		}		
		
		// Mouse Events 
		private function setUpMouseEvents(){
			switch (currentLabel) {
				case 'startMenu':
					startMenuButton.addEventListener(MouseEvent.MOUSE_UP, beginIntroComic);
					newSound = MAIN_THEME;
					checkSound();
					break;
				case 'introComic':
					introHouseButton.addEventListener(MouseEvent.MOUSE_UP, goOutsideHouse);
					IntroComicSetup();
					newSound = MAIN_THEME;
					checkSound();
					break;
				case 'outsideHouse':
					enterForestButton.addEventListener(MouseEvent.MOUSE_UP, goInForest);
					newSound = FOREST_THEME;
					checkSound();
					break;
				case 'forestEntrance':
					toFountainButton.addEventListener(MouseEvent.MOUSE_UP, goToFountain);
					potionOverworld.addEventListener(MouseEvent.MOUSE_UP, getPotion);
					toOutsideHouseButton.addEventListener(MouseEvent.MOUSE_UP, goOutsideHouse);
					newSound = FOREST_THEME;
					checkSound();
					break;
				case 'boarFountain':
					toBoarButton.addEventListener(MouseEvent.MOUSE_UP, goBoarEncounter);
					backToForestButton.addEventListener(MouseEvent.MOUSE_UP, goInForest);
					newSound = FOREST_THEME;
					checkSound();
					break;
				case 'boarEncounter':
					backtoFountainButton.addEventListener(MouseEvent.MOUSE_UP, goToFountain);
					toShieldButton.addEventListener(MouseEvent.MOUSE_UP, goToShield);
				
					//FOR NOW THIS IS ONE CLICK THERE WILL BE TWO OPTIONS
					boarOverworld.addEventListener(MouseEvent.MOUSE_UP, beginBoarComic);
					newSound = FOREST_THEME;
					checkSound();
					break;
				case 'boarComic':
					leaveBoarComicButton.addEventListener(MouseEvent.MOUSE_UP, goBoarEncounter);
					leaveBoarComicButton.visible = false;
					boarButtonGood.addEventListener(MouseEvent.MOUSE_UP, BoarGoodSetup);
					boarButtonBad.addEventListener(MouseEvent.MOUSE_UP, BoarBadSetup);
					boarComicGood.visible = false;
					boarComicBad.visible = false;
					newSound = FOREST_THEME;
					checkSound();
					break;
				case 'findShield':
					backToBoarButton.addEventListener(MouseEvent.MOUSE_UP, goBoarEncounter);
					toCaveButton.addEventListener(MouseEvent.MOUSE_UP, goCaveEntrance);
					shieldOverworld.addEventListener(MouseEvent.MOUSE_UP, getShield);
					newSound = FOREST_THEME;
					checkSound();
					break;
				case 'caveEntrance':
					toSwampButton.addEventListener(MouseEvent.MOUSE_UP, goToSwamp);
					toMuralOneButton.addEventListener(MouseEvent.MOUSE_UP, goToMuralOne);
					backToShieldButton.addEventListener(MouseEvent.MOUSE_UP, goToShield);
					newSound = FOREST_THEME;
					checkSound();
					break;
				case 'muralPartOne':
					backToCaveButton.addEventListener(MouseEvent.MOUSE_UP, goCaveEntrance);
					toMuralPartTwoButton.addEventListener(MouseEvent.MOUSE_UP, goToMuralTwo);
					newSound = CAVE_THEME;
					checkSound();
					break;
				case 'muralPartTwo':
					backToMuralPartOneButton.addEventListener(MouseEvent.MOUSE_UP, goToMuralOne);
					toLionButton.addEventListener(MouseEvent.MOUSE_UP, goLionEncounter);
					newSound = CAVE_THEME;
					checkSound();
					break;
				case 'lionEncounter':
					lionOverworld.addEventListener(MouseEvent.MOUSE_UP, beginLionComic);
					backToMuralTwoButton.addEventListener(MouseEvent.MOUSE_UP, goToMuralTwo);
					toAmuletButton.addEventListener(MouseEvent.MOUSE_UP, goDragonAmulet);
					newSound = CAVE_THEME;
					checkSound();
					break;
				case 'lionComic':
					backToLionOneButton.addEventListener(MouseEvent.MOUSE_UP, goLionEncounter);
					backToLionOneButton.visible = false;
					lionButtonGood.addEventListener(MouseEvent.MOUSE_UP, LionGoodSetup);
					lionButtonBad.addEventListener(MouseEvent.MOUSE_UP, LionBadSetup);
					lionComicGood.visible = false;
					lionComicBad.visible = false;
					newSound = CAVE_THEME;
					checkSound();
					break;
				case 'dragonAmulet':
					backToLionTwoButton.addEventListener(MouseEvent.MOUSE_UP, goLionEncounter); 
					amuletOverworld.addEventListener(MouseEvent.MOUSE_UP, getAmulet);
					newSound = CAVE_THEME;
					checkSound();
					break;
				case 'swampTransition':
					backToCaveButtonTwo.addEventListener(MouseEvent.MOUSE_UP, goCaveEntrance);
					toDragonArchwayButton.addEventListener(MouseEvent.MOUSE_UP, goDragonArch);
					newSound = SWAMP_THEME;
					checkSound();
					break;
				case 'dragonArchway':
					backToSwampButton.addEventListener(MouseEvent.MOUSE_UP, goToSwamp);
					toSwampHouseButton.addEventListener(MouseEvent.MOUSE_UP, goDragonFar);
					newSound = SWAMP_THEME;
					checkSound();
					break;
				case 'damPath':
					toDragonDamButton.addEventListener(MouseEvent.MOUSE_UP, goDragonDam);
					toDragonFarButton.addEventListener(MouseEvent.MOUSE_UP, goDragonFar);
					newSound = SWAMP_THEME;
					checkSound();
					//Maybe add the thing with the wanted poster?
					break;
				case 'dragonFarOff':
					backToSwampHouseButton.addEventListener(MouseEvent.MOUSE_UP, goDragonArch);
					toDragonCloseButton.addEventListener(MouseEvent.MOUSE_UP, goDragonClose);
					toDamButton.addEventListener(MouseEvent.MOUSE_UP, goDamPath);
					newSound = SWAMP_THEME;
					checkSound();
					break;
				case 'dragonCloseUp':
					backToDragonFarButton.addEventListener(MouseEvent.MOUSE_UP, goDragonFar);
					newSound = SWAMP_THEME;
					checkSound();
					break;
				case 'damDragon':
					damOverworld.addEventListener(MouseEvent.MOUSE_UP, beginDragonComic);
					backToDragonFarButtonTwo.addEventListener(MouseEvent.MOUSE_UP, goDamPath);
					newSound = SWAMP_THEME;
					checkSound();
					break;
				case 'dragonComic':
					toEndComicButton.addEventListener(MouseEvent.MOUSE_UP, goCredits);
					toEndComicButton.visible = false;
					dragonButtonGood.addEventListener(MouseEvent.MOUSE_UP, DragonGoodSetup);
					dragonButtonBad.addEventListener(MouseEvent.MOUSE_UP, DragonBadSetup);
					dragonComicGood.visible = false;
					dragonComicBad.visible = false;
					newSound = SWAMP_THEME;
					checkSound();
					break;
				/*case 'endComic':
					toCreditsButton.addEventListener(MouseEvent.MOUSE_UP, goCredits);
					toCreditsButton.visible = false;
					newSound = MAIN_THEME;
					checkSound();
					break;*/
				case 'credits':
					returnToMenuButton.addEventListener(MouseEvent.MOUSE_UP, goMAINMENU);
					returnToMenuButton.visible = false;
					creditScroll.addEventListener(Event.ENTER_FRAME, checkEndFrame);
					newSound = MAIN_THEME;
					checkSound();
					break;
			}
			
			
		}
		
		//Clear the events from the frame before leaving
		private function clearMouseEvents(){
			try{ //Leaving startMenu
				startMenuButton.removeEventListener(MouseEvent.MOUSE_UP, beginIntroComic);
			} catch(e:Error) {}
			
			try{ //Leaving introComic
				introHouseButton.removeEventListener(MouseEvent.MOUSE_UP, goInsideHouse);
			} catch(e:Error) {}
			
			try{ //Leaving outsideHouse
				enterForestButton.removeEventListener(MouseEvent.MOUSE_UP, goInForest);
			} catch(e:Error) {}
			
			try{ //Leaving forestEntrance
				toFountainButton.removeEventListener(MouseEvent.MOUSE_UP, goToFountain);
				potionOverworld.removeEventListener(MouseEvent.MOUSE_UP, getPotion);
				toOutsideHouseButton.removeEventListener(MouseEvent.MOUSE_UP, goOutsideHouse);
			} catch(e:Error) {}
			
			try{ //Leaving boarFountain
				toBoarButton.removeEventListener(MouseEvent.MOUSE_UP, goBoarEncounter);
				backToForestButton.removeEventListener(MouseEvent.MOUSE_UP, goInForest);
			} catch(e:Error) {}
			
			try{ //Leaving boarEncounter
				backtoFountainButton.removeEventListener(MouseEvent.MOUSE_UP, goToFountain);
				toShieldButton.removeEventListener(MouseEvent.MOUSE_UP, goToShield);
				
				//FOR NOW THIS IS ONE CLICK THERE WILL BE TWO OPTIONS
				boarOverworld.removeEventListener(MouseEvent.MOUSE_UP, beginBoarComic);
			} catch(e:Error) {}
			
			try{ //Leaving boarComic
				leaveBoarComicButton.removeEventListener(MouseEvent.MOUSE_UP, goBoarEncounter);
			} catch(e:Error) {}
			
			try{ //Leaving findShield
				backToBoarButton.removeEventListener(MouseEvent.MOUSE_UP, goBoarEncounter);
				toCaveButton.removeEventListener(MouseEvent.MOUSE_UP, goCaveEntrance);
			} catch(e:Error) {}
			
			try{ //Leaving caveEntrance
				toSwampButton.removeEventListener(MouseEvent.MOUSE_UP, goToSwamp);
				toMuralOneButton.removeEventListener(MouseEvent.MOUSE_UP, goToMuralOne);
				backToShieldButton.removeEventListener(MouseEvent.MOUSE_UP, goToShield);
			} catch(e:Error) {}
			
			try{ //Leaving muralPartOne
				backToCaveButton.removeEventListener(MouseEvent.MOUSE_UP, goCaveEntrance);
				toMuralPartTwoButton.removeEventListener(MouseEvent.MOUSE_UP, goToMuralTwo)
			} catch(e:Error) {}
			
			try{ //Leaving muralPartTwo
				backToMuralPartOneButton.removeEventListener(MouseEvent.MOUSE_UP, goToMuralOne);
				toLionButton.removeEventListener(MouseEvent.MOUSE_UP, goLionEncounter);
			} catch(e:Error) {}
			
			try{ //Leaving lionEncounter
				lionOverworld.removeEventListener(MouseEvent.MOUSE_UP, beginLionComic);
				toAmuletButton.removeEventListener(MouseEvent.MOUSE_UP, goDragonAmulet);
			} catch(e:Error) {}
			
			try{ //Leaving lionComic
				backToLionOneButton.removeEventListener(MouseEvent.MOUSE_UP, goLionEncounter);
			} catch(e:Error) {}
			
			try{ //Leaving dragonAmulet
				backToLionTwoButton.removeEventListener(MouseEvent.MOUSE_UP, goLionEncounter);
				amuletOverworld.removeEventListener(MouseEvent.MOUSE_UP, getAmulet);
			} catch(e:Error) {}
			
			try{ //Leaving swampTransition
				backToCaveButtonTwo.removeEventListener(MouseEvent.MOUSE_UP, goCaveEntrance);
				toDragonArchwayButton.removeEventListener(MouseEvent.MOUSE_UP, goDragonArch);
			} catch(e:Error) {}
			
			try{ //Leaving dragonArchway
				backToSwampButton.removeEventListener(MouseEvent.MOUSE_UP, goToSwamp);
				toSwampHouseButton.removeEventListener(MouseEvent.MOUSE_UP, goDragonFar);
			} catch(e:Error) {}
			
			try{ //Leaving damPath
				toDragonDamButton.removeEventListener(MouseEvent.MOUSE_UP, goDragonDam);
				toDragonFarButton.removeEventListener(MouseEvent.MOUSE_UP, goDragonFar);
				//Maybe add the thing with the wanted poster?
			} catch(e:Error) {}
			
			try{ //Leaving dragonFarOff
				backToSwampHouseButton.removeEventListener(MouseEvent.MOUSE_UP, goDragonArch);
				toDragonCloseButton.removeEventListener(MouseEvent.MOUSE_UP, goDragonClose);
				toDamButton.removeEventListener(MouseEvent.MOUSE_UP, goDamPath);
			} catch(e:Error) {}
			
			try{ //Leaving dragonCloseUp
				backToDragonFarButton.removeEventListener(MouseEvent.MOUSE_UP, goDragonFar);
			} catch(e:Error) {}
			
			try{ //Leaving damDragon
				damOverworld.removeEventListener(MouseEvent.MOUSE_UP, beginDragonComic);
				backToDragonFarButtonTwo.removeEventListener(MouseEvent.MOUSE_UP, goDamPath);
			} catch(e:Error) {}
			
			try{ //Leaving dragonComic
				toEndComicButton.removeEventListener(MouseEvent.MOUSE_UP, goCredits);
			} catch(e:Error) {}
			
			//try{ //Leaving endComic
			//	toCreditsButton.removeEventListener(MouseEvent.MOUSE_UP, goCredits);
			//} catch(e:Error) {}
			
			try{ //Leaving credits
				returnToMenuButton.removeEventListener(MouseEvent.MOUSE_UP, goMAINMENU);
			} catch(e:Error) {}
			
		}
		
		// AUDIO EVENTS --------------------------------------------------------------------------------------------------------
		private function checkSound():void{
			if (currentSound != newSound){
				currentSound = newSound;
				backgroundChannel.stop();
				if (currentSound == MAIN_THEME){
					backgroundChannel = drip.play(0,9999);					
				} else if (currentSound == FOREST_THEME){
					backgroundChannel = forest.play(0,9999);
				} else if (currentSound == CAVE_THEME){
					backgroundChannel = cave.play(0,9999);
				} else if (currentSound == SWAMP_THEME){
					backgroundChannel = swamp.play(0,9999);
				}
			}
		}
		
		
		// ITEM EVENTS ---------------------------------------------------------------------------------------------------------
		private function getPotion(evt:MouseEvent){
			trace('PotionClicked');
			havePotion = true;
			potionOverworld.visible = false;
			
			var potionPop = new PopUpBox();
			potionPop.infoPop.text = POTION_MSG;
			potionPop.infoPop.mouseEnabled = false;
			addChild(potionPop);
			potionPop.addEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
		}
		private function getShield(evt:MouseEvent){
			trace('ShieldClicked');
			haveShield = true;
			shieldOverworld.visible = false;
			
			var shieldPop = new PopUpBox();
			shieldPop.infoPop.text = SHIELD_MSG;
			shieldPop.infoPop.mouseEnabled = false;
			addChild(shieldPop);
			shieldPop.addEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
		}
		private function getAmulet(evt:MouseEvent){
			trace('AmuletClicked');
			haveAmulet = true;
			amuletOverworld.visible = false;
			
			var amuletPop = new PopUpBox();
			amuletPop.infoPop.text = AMULET_MSG;
			amuletPop.infoPop.mouseEnabled = false;
			addChild(amuletPop);
			amuletPop.addEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
		}
		
		//FADE TEXT AWAY
		/*private function fadeOutText(evt:Event){
			var fadingText = evt.target;
			if (fadingText.alpha > 0){
				fadingText.alpha -= .02;
			} else {
				fadingText.removeEventListener(Event.ENTER_FRAME, fadeOutText);
				removeChild(fadingText);
			}
		}*/
		private function destroyPopUp(evt:MouseEvent){
			var toDestroy = evt.target;
			trace(toDestroy);
			toDestroy.removeEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
			removeChild(toDestroy);
		}
		
		// COMIC EVENTS --------------------------------------------------------------------------------------------------------
		//Transition from startMenu to introComic
		private function beginIntroComic(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('introComic');
			setUpMouseEvents();
		}
		//Transition from boarEncounter to boarComic
		private function beginBoarComic(evt:MouseEvent){
			if (!havePotion){
				var boarPop = new PopUpBox();
				boarPop.infoPop.text = BOAR_MSG;
				boarPop.infoPop.mouseEnabled = false;
				addChild(boarPop);
				boarPop.addEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
			} else {
				clearMouseEvents();
				gotoAndStop('boarComic');
				setUpMouseEvents();
			}
		}
		//Trasition from lionEncounter to lionComic
		private function beginLionComic(evt:MouseEvent){
			if (!haveShield){
				var lionPop = new PopUpBox();
				lionPop.infoPop.text = LION_MSG;
				lionPop.infoPop.mouseEnabled = false;
				addChild(lionPop);
				lionPop.addEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
			} else {
				clearMouseEvents();
				gotoAndStop('lionComic');
				setUpMouseEvents();
			}
			
		}
		//Trasition from damDragon to dragonComic
		private function beginDragonComic(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('dragonComic');
			setUpMouseEvents();
		}
		//Trasition from dragonComic to endComic
		/*private function beginEndComic(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('endComic');
			setUpMouseEvents();
			var goodCount:int = 0;
			var badCount:int = 0;
			if (boarAlive){
				goodCount += 1;
			} else {
				badCount += 1;
			}
			if (lionAlive){
				goodCount += 1;
			} else {
				badCount += 1;
			}
			if (dragonAlive){
				goodCount += 1;
			} else {
				badCount += 1;
			}
			trace(goodCount, badCount);
			
			if (goodCount > badCount){
				endComicBad.visible = false;
				endComicGood.addEventListener(MouseEvent.MOUSE_UP, EndComicAdvance);
			} else {
				endComicGood.visible = false;
				endComicBad.addEventListener(MouseEvent.MOUSE_UP, EndComicAdvance);
			}
		}*/
		
		
		// TRANSITIONAL EVENTS --------------------------------------------------------------------------------------------------------
		//Transition from introComic to insideHouse
		//Or from outsideHouse to insideHouse
		private function goInsideHouse(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('insideHouse');
			setUpMouseEvents();
		}
		//Transition from insideHouse to outsideHouse
		//Or from forestEntrance to outsideHouse
		private function goOutsideHouse(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('outsideHouse');
			setUpMouseEvents();
		}
		//Transition from outsideHouse to forest
		//Or from boarFountain to forestEntrance
		private function goInForest(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('forestEntrance');
			setUpMouseEvents();
			if (havePotion == false && potionOverworld != null){
				potionOverworld.visible = true;
			} else {
				potionOverworld.visible = false;
			}
		}
		//Transition from forestEntrance to boarFountain
		//Or from boarEncounter to boarFountain
		private function goToFountain(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('boarFountain');
			setUpMouseEvents();
		}
		//Transition from boarFountain to boarEncounter
		//Or from findSheild to boarEncounter
		//Or from boarComic to boarEncounter
		private function goBoarEncounter(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('boarEncounter');
			setUpMouseEvents();
			if(boarAlive && !boarHelped){
				if (boarOverworld != null){
					boarOverworld.visible = true;
				}
			} else if (boarOverworld != null){
				boarOverworld.visible = false;
			}
		}
		//Transition from boarEncounter to findShield
		//Or from caveEntrance to findShield
		private function goToShield(evt:MouseEvent){
			if (boarAlive && !boarHelped){
				var boarPop = new PopUpBox();
				boarPop.infoPop.text = BOAR_EARLY_MSG;
				boarPop.infoPop.mouseEnabled = false;
				addChild(boarPop);
				boarPop.addEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
			} else {
				clearMouseEvents();
				gotoAndStop('findShield');
				setUpMouseEvents();
				if (!haveShield && shieldOverworld != null){
					shieldOverworld.visible = true;
				} else if (shieldOverworld != null){
					shieldOverworld.visible = false;
				}
			}
		}
		//Transition from findShield to caveEntrance
		//Or from muralPartOne to caveEntrance
		private function goCaveEntrance(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('caveEntrance');
			setUpMouseEvents();
		}
		//Transition from caveEntrance to swampTransition
		//Or from dragonArchway to swampTransition
		private function goToSwamp(evt:MouseEvent){
			if (lionAlive && !lionHelped){
				var rockPop = new PopUpBox();
				rockPop.infoPop.text = STONE_MSG;
				rockPop.infoPop.mouseEnabled = false;
				addChild(rockPop);
				rockPop.addEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
			} else {
				clearMouseEvents();
				gotoAndStop('swampTransition');
				setUpMouseEvents();
			}
		}
		//Transition from caveEntrance to muralPartOne
		//Or from muralPartTwo to muralPartOne
		private function goToMuralOne(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('muralPartOne');
			setUpMouseEvents();
			if (boarAlive){
				muralPartOne.gotoAndStop(1);
			} else {
				muralPartOne.gotoAndStop(2);
			}
		}
		//Transition from muralPartOne to muralPartTwo
		//Or from lionEncounter to muralPartTwo
		private function goToMuralTwo(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('muralPartTwo');
			setUpMouseEvents();
			if (boarAlive){
				muralPartTwo.gotoAndStop(1);
			} else {
				muralPartTwo.gotoAndStop(2);
			}
		}
		//Transition from muralPartTwo to lionEncounter
		//Or from dragonAmulet to lionEncounter
		//Or from lionComic to lionEncounter
		private function goLionEncounter(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('lionEncounter');
			setUpMouseEvents();
			if(lionAlive && !lionHelped){
				if (lionOverworld != null){
					lionOverworld.visible = true;
				}
			} else if (lionOverworld != null){
				lionOverworld.visible = false;
			}
		}
		//Transition from lionEncounter to dragonAmulet
		private function goDragonAmulet(evt:MouseEvent){
			if (lionAlive && !lionHelped){
				var lBlockPop = new PopUpBox();
				lBlockPop.infoPop.text = LION_BLOCK_MSG;
				lBlockPop.infoPop.mouseEnabled = false;
				addChild(lBlockPop);
				lBlockPop.addEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
			} else {
				clearMouseEvents();
				gotoAndStop('dragonAmulet');
				setUpMouseEvents();
				if (!haveAmulet && amuletOverworld != null){
					amuletOverworld.visible = true;
				} else if (amuletOverworld != null){
					amuletOverworld.visible = false;
				}
			}
		}
		//Transition from swampTrasition to dragonArchway
		//Or from swampHouse to dragonArchway
		private function goDragonArch(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('dragonArchway');
			setUpMouseEvents();
		}
		//Transition from dragonFarOff to damPath
		//Or from damDragon to damPath
		private function goDamPath(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('damPath');
			setUpMouseEvents();
		}
		//Transition from swampHouse to dragonFarOff
		//Or from dragonCloseUp to dragonFarOff
		//Or from damDragon to dragonFarOff
		private function goDragonFar(evt:MouseEvent){
			if (!haveAmulet){
				var swampPop = new PopUpBox();
				swampPop.infoPop.text = SWAMP_MSG;
				swampPop.infoPop.mouseEnabled = false;
				addChild(swampPop);
				swampPop.addEventListener(MouseEvent.MOUSE_UP, destroyPopUp);
			} else {
				clearMouseEvents();
				gotoAndStop('dragonFarOff');
				setUpMouseEvents();
			}
		}
		//Transition from dragonFarOff to dragonCloseUp
		private function goDragonClose(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('dragonCloseUp');
			setUpMouseEvents();
		}
		//Transition from dragonFarOff to damDragon
		private function goDragonDam(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('damDragon');
			setUpMouseEvents();
		}
		
		
		//Credits and back to Main
		private function goCredits(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('credits');
			setUpMouseEvents();
		}
		private function goMAINMENU(evt:MouseEvent){
			clearMouseEvents();
			gotoAndStop('startMenu');
			resetValues();
			setUpMouseEvents();
		}
		
		
		
		//ComicSetUps --------------------------------------------------------------------------------------------------------
		//INTRO
		private function IntroComicSetup(){
			IntroComic_MC.stop();
			IntroComic_MC.mouseChildren = false;
			IntroComic_MC.addEventListener(MouseEvent.MOUSE_UP, IntroComicAdvance);
			introHouseButton.visible = false;
		}
		private function IntroComicAdvance(evt:MouseEvent){
			if (IntroComic_MC.currentFrame == IntroComic_MC.totalFrames){
				introHouseButton.visible = true;
				IntroComic_MC.removeEventListener(MouseEvent.MOUSE_UP, IntroComicAdvance);
			}
			IntroComic_MC.gotoAndStop(IntroComic_MC.currentFrame + 1);
		}
		
		
		//BOARGOOD
		private function BoarGoodSetup(evt:MouseEvent){
			boarHelped = true;
			boarButtonGood.removeEventListener(MouseEvent.MOUSE_UP, BoarGoodSetup);
			boarButtonBad.removeEventListener(MouseEvent.MOUSE_UP, BoarBadSetup);
			boarComicGood.visible = true;
			boarComicGood.mouseChildren = false;
			boarComicGood.gotoAndStop(1);
			boarComicGood.addEventListener(MouseEvent.MOUSE_UP, BoarGoodAdvance);
		}
		private function BoarGoodAdvance(evt:MouseEvent){
			if (boarComicGood.currentFrame == boarComicGood.totalFrames){
				leaveBoarComicButton.visible = true;
				boarComicGood.removeEventListener(MouseEvent.MOUSE_UP, BoarGoodAdvance);
			}
			
			boarComicGood.gotoAndStop(boarComicGood.currentFrame + 1);
		}
		//BOARBAD
		private function BoarBadSetup(evt:MouseEvent){
			boarAlive = false;
			boarButtonGood.removeEventListener(MouseEvent.MOUSE_UP, BoarGoodSetup);
			boarButtonBad.removeEventListener(MouseEvent.MOUSE_UP, BoarBadSetup);
			boarComicBad.visible = true;
			boarComicBad.mouseChildren = false;
			boarComicBad.gotoAndStop(1);
			boarComicBad.addEventListener(MouseEvent.MOUSE_UP, BoarBadAdvance);
		}
		private function BoarBadAdvance(evt:MouseEvent){
			if (boarComicBad.currentFrame == boarComicBad.totalFrames){
				leaveBoarComicButton.visible = true;
				boarComicBad.removeEventListener(MouseEvent.MOUSE_UP, BoarBadAdvance);
			}
			boarComicBad.gotoAndStop(boarComicBad.currentFrame + 1);
		}
		
		
		
		//LIONGOOD
		private function LionGoodSetup(evt:MouseEvent){
			lionHelped = true;
			lionButtonGood.removeEventListener(MouseEvent.MOUSE_UP, LionGoodSetup);
			lionButtonBad.removeEventListener(MouseEvent.MOUSE_UP, LionBadSetup);
			lionComicGood.visible = true;
			lionComicGood.mouseChildren = false;
			lionComicGood.gotoAndStop(1);
			lionComicGood.addEventListener(MouseEvent.MOUSE_UP, LionGoodAdvance);
		}
		private function LionGoodAdvance(evt:MouseEvent){
			if (lionComicGood.currentFrame == lionComicGood.totalFrames){
				backToLionOneButton.visible = true;
				lionComicGood.removeEventListener(MouseEvent.MOUSE_UP, LionGoodAdvance);
			}
			lionComicGood.gotoAndStop(lionComicGood.currentFrame + 1);
		}
		//LIONBAD
		private function LionBadSetup(evt:MouseEvent){
			lionAlive = false;
			lionButtonGood.removeEventListener(MouseEvent.MOUSE_UP, LionGoodSetup);
			lionButtonBad.removeEventListener(MouseEvent.MOUSE_UP, LionBadSetup);
			lionComicBad.visible = true;
			lionComicBad.mouseChildren = false;
			lionComicBad.gotoAndStop(1);
			lionComicBad.addEventListener(MouseEvent.MOUSE_UP, LionBadAdvance);
		}
		private function LionBadAdvance(evt:MouseEvent){
			if (lionComicBad.currentFrame == lionComicBad.totalFrames){
				backToLionOneButton.visible = true;
				lionComicBad.removeEventListener(MouseEvent.MOUSE_UP, LionBadAdvance);
			}
			lionComicBad.gotoAndStop(lionComicBad.currentFrame + 1);
		}
		
		//DRAGONGOOD
		private function DragonGoodSetup(evt:MouseEvent){
			dragonHelped = true;
			dragonButtonGood.removeEventListener(MouseEvent.MOUSE_UP, DragonGoodSetup);
			dragonButtonBad.removeEventListener(MouseEvent.MOUSE_UP, DragonBadSetup);
			dragonComicGood.visible = true;
			dragonComicGood.mouseChildren = false;
			dragonComicGood.gotoAndStop(1);
			dragonComicGood.addEventListener(MouseEvent.MOUSE_UP, DragonGoodAdvance);
		}
		private function DragonGoodAdvance(evt:MouseEvent){
			if (dragonComicGood.currentFrame == dragonComicGood.totalFrames){
				toEndComicButton.visible = true;
				dragonComicGood.removeEventListener(MouseEvent.MOUSE_UP, DragonGoodAdvance);
			}
			dragonComicGood.gotoAndStop(dragonComicGood.currentFrame + 1);
		}
		//DRAGONBAD
		private function DragonBadSetup(evt:MouseEvent){
			dragonAlive = false;
			dragonButtonGood.removeEventListener(MouseEvent.MOUSE_UP, DragonGoodSetup);
			dragonButtonBad.removeEventListener(MouseEvent.MOUSE_UP, DragonBadSetup);
			dragonComicBad.visible = true;
			dragonComicBad.mouseChildren = false;
			dragonComicBad.gotoAndStop(1);
			dragonComicBad.addEventListener(MouseEvent.MOUSE_UP, DragonBadAdvance);
		}
		private function DragonBadAdvance(evt:MouseEvent){
			if (dragonComicBad.currentFrame == dragonComicBad.totalFrames){
				toEndComicButton.visible = true;
				dragonComicBad.removeEventListener(MouseEvent.MOUSE_UP, DragonBadAdvance);
			}
			dragonComicBad.gotoAndStop(dragonComicBad.currentFrame + 1);
		}
		
		////ENDCOMIC
		//private function EndComicAdvance(evt:MouseEvent){
		//	var CLICKER = evt.target;
		//	if (CLICKER.currentFrame == CLICKER.totalFrames){
		//		CLICKER.removeEventListener(MouseEvent.MOUSE_UP, EndComicAdvance);
		//		toCreditsButton.visible = true;
		//	}
		//	CLICKER.gotoAndStop(CLICKER.currentFrame + 1);
		//}
		
		//STOP FROM SKIPPING CREDITS
		private function checkEndFrame(evt:Event){
			var CHECKER = evt.target;
			if (CHECKER.currentFrame == CHECKER.totalFrames){
				CHECKER.removeEventListener(Event.ENTER_FRAME, checkEndFrame);
				returnToMenuButton.visible = true;
			}
		}
	}
	
}
