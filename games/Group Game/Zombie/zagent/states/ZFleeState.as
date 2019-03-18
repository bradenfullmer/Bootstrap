package Zombie.zagent.states 
{
	import Zombie.zagent.ZAgent;
	/**
	 * ...
	 * @author Andreas Rønning
	 */
	public class ZFleeState implements IAgentStateZ
	{
		
		public function ZFleeState() 
		{
			
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:ZAgent):void
		{
			if (a.numCycles < 10) return;
			a.say("Fleeing!");
			a.speed = 2;
			a.faceMouse( -1);
			if(a.numCycles>80){
				if (a.distanceToMouse > a.fleeRadius) {
					a.setState(ZAgent.CONFUSED);
				}
			}
		}
		
		public function enter(a:Agent):void
		{
			a.say("Eek!");
			a.faceMouse(1);
			a.speed = 0;
		}
		
		public function exit(a:Agent):void
		{
			
		}
		
	}

}