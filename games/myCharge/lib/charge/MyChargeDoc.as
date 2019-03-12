package lib.charge
{
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import lib.charge.MyChargeGame;
	
	public class MyChargeDoc extends MovieClip
	{
		public function MyChargeDoc()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			createStartMenu();
			trace("constructor");
		}
		
		private function createStartMenu():void
		{
			var startMenu:StartScreen = new StartScreen();
			
			addChild(startMenu);
			trace("added start menu");
			
			startMenu.startButton.addEventListener(MouseEvent.CLICK, startGameHandler);
		}
		
		private function startGameHandler(evt:MouseEvent):void
		{
			removeChild(evt.currentTarget.parent);
			
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);
			
			createGame();
		}
		
		private function createGame():void
		{
			var game:MyChargeGame = new MyChargeGame();
			
			addChild(game);
		}
	}
}