package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class MainMenu extends MovieClip {


		public function MainMenu() {
			// constructor code

			createStartScreen();


		}

		private function createStartScreen(): void {
			var mainScreen: MainScreen = new MainScreen();

			addChild(mainScreen);
			trace("Start Game!");
			mainScreen._play.addEventListener(MouseEvent.CLICK, startGame);
			mainScreen._credits.addEventListener(MouseEvent.MOUSE_DOWN, displayCredits);
			mainScreen._help.addEventListener(MouseEvent.CLICK, displayHelp);
		}
		private function startGame(evt: MouseEvent): void {
			removeChild(evt.currentTarget.parent);
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGame);
			createGame();
		}


		private function displayHelp(evt: MouseEvent): void {
			var helpScreen: HelpScreen = new HelpScreen();
			addChild(helpScreen);
			trace("Help Displayed!");
			helpScreen._close.addEventListener(MouseEvent.CLICK, close);
		}
		private function close(evt: MouseEvent): void {
			removeChild(evt.currentTarget.parent);
			trace("Help Removed!");
		}
		private function createGame(): void {
			var game: DungeonCrawl = new DungeonCrawl();
			addChild(game);
		}
		private function displayCredits(evt: MouseEvent): void {
			var creditsScreen: CreditsScreen = new CreditsScreen();
			addChild(creditsScreen);
			creditsScreen._close.addEventListener(MouseEvent.CLICK, close);
		}

	}
}