package  {
	
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import lib.charge.MyChargeGame;
	
	public class MyEndGame extends MovieClip {

		public function MyEndGame() {
			// constructor code
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			createEndMenu();
		}
		
		private function createEndMenu():void
		{
			var endMenu:EndScreen = new EndScreen();
			
			addChild(endMenu);
			trace("added start menu");
			
			endMenu.tryAgain.addEventListener(MouseEvent.CLICK, restartGameHandler);
		}
		
		private function restartGameHandler(evt:MouseEvent):void
		{
			removeChild(evt.currentTarget.parent);
			
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, restartGameHandler);
			
			restartGame();
		}
		
		private function restartGame():void
		{
			var game:MyChargeGame = new MyChargeGame();
			
			addChild(game);
		}
	}
}