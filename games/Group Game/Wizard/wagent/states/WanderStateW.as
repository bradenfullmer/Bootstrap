package Wizard.wagent.states 
{
	import Wizard.wagent.AgentW;
	public class WanderStateW implements IAgentStateW
	{
		
		public function update(w:AgentW):void
		{
			w.say("Wandering...");
			w.velocity.x += Math.random() * 0.2 - 0.1;
			w.velocity.y += Math.random() * 0.2 - 0.1;
			w.speed = .8;
			if (w.numCycles > Math.random() * 50 + 50) {
				w.setState(AgentW.IDLE);
				w.setState(AgentW.IDLE);
			}
			if (!w.canSeeMouse) return;
			if (w.distanceToMouse < w.fleeRadius) {
				w.setState(AgentW.FLEE);
			}else if (w.distanceToMouse < w.chaseRadius) {
				w.setState(AgentW.CHASE);
			}
		}
		
		public function enter(w:AgentW):void
		{
			w.speed = .8;
		}
		
		public function exit(w:AgentW):void
		{
			
		}
	}
}