package  {
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.ui.Mouse;
	
	public class ChestMain extends MovieClip {
		
		private var ClosedChest:MovieClip;
		private var Key:SimpleButton;
		private var OpenChest:MovieClip;
		private var Loot:MovieClip;
		private var Loot2:MovieClip;
		private var Loot3:MovieClip;
		
		public function ChestMain() {
			ClosedChest = new closedChest();
			Key = new key();
			OpenChest = new openChest();
			Loot = new loot();
			Loot2 = new loot();
			Loot3 = new loot();
			
			Key.x = ClosedChest.width/2;
			Key.y = ClosedChest.height/4;
			addChild(ClosedChest);
			addChild(Key);
			
			Key.addEventListener(MouseEvent.CLICK, chestOpen);
			
		}
		public function chestOpen(evt:MouseEvent) {
			trace("Chest has opened");
			removeChild(ClosedChest);
			addChild(OpenChest);
			checkForLoot();
			
		}
		
		public function checkForLoot() {
			trace("Loot was dropped");
			Loot.x = 100;
			Loot.y = 100;
			Loot2.x = 150;
			Loot2.y = 100;
			Loot3.x = 50;
			Loot3.y = 100;
			addChild(Loot);
			addChild(Loot2);
			addChild(Loot3);
			}
			
		public function chestClose() {
			trace("Chest is closed");

		}
	}
}