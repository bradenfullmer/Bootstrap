package Wizard.wagent.states  
{
	import Wizard.wagent.AgentW;
	/**
	 * ...
	 * @author Andreas Rønning
	 */
	public class ShootStateW implements IAgentStateW
	{
		
		public function ShootStateW() 
		{
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(w:AgentW):void
		{
			if (w.numCycles < 10) return;
			w.say("DIE!");
			w.speed = 0;
			w.faceMouse( 1);
			if (w.distanceToMouse > w.shootRadius) {
				w.setState(AgentW.CHASE);
			}
			if (w.distanceToMouse < w.fleeRadius) {
				w.setState(AgentW.FLEE);
			}
			
		}
		
		public function enter(w:AgentW):void
		{
			w.say("DIE!");
			w.faceMouse(1);
			w.speed = 0;
		}
		
		public function exit(w:AgentW):void
		{
			
		}
		
	}

}