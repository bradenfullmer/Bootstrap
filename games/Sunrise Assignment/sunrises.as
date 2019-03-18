package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class sunrises extends MovieClip {

		public function sunrises() {
			// constructor code
			rise_btn.addEventListener(MouseEvent.MOUSE_DOWN, playTimeline1);
			set_btn.addEventListener(MouseEvent.MOUSE_DOWN, playTimeline2);
			wave_btn.addEventListener(MouseEvent.MOUSE_DOWN, playTimeline3);
		}
		function playTimeline1(evt: MouseEvent): void {
			this.sky.gotoAndPlay(2);
			this.sun.gotoAndPlay(2);
			this.window.gotoAndPlay(2);
			this.ship.gotoAndPlay(2);
		}
		

		function playTimeline2(evt: MouseEvent): void {
			this.sky.gotoAndPlay(23);
			this.sun.gotoAndPlay(23);
			this.window.gotoAndPlay(23);
			this.ship.gotoAndPlay(14)
			this.alien.gotoAndPlay(15)
			this.textEffect.gotoAndPlay(72)
		}
		
		function playTimeline3(evt: MouseEvent): void {
			this.alien.gotoAndPlay(2);
		}
		

	}

}