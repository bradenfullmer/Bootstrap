package Skeleton.sagent.states  
{
	import Skeleton.sagent.AgentS;
	/**
	 * ...
	 * @author Andreas Rønning
	 */
	public class FleeStateS implements IAgentStateS
	{
		
		public function FleeStateS() 
		{
			
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(s:AgentS):void
		{
			if (s.numCycles < 10) return;
			s.say("Fleeing!");
			s.speed = 1;
			s.faceMouse( -1);
			if (s.distanceToMouse > s.fleeRadius) {
				s.setState(AgentS.SHOOT);
			}
			if (s.distanceToMouse < s.meleeRadius) {
				s.setState(AgentS.ATTACK);
			}
		}
		
		public function enter(s:AgentS):void
		{
			s.say("Eek!");
			s.faceMouse(1);
			s.speed = 0;
		}
		
		public function exit(s:AgentS):void
		{
			
		}
		
	}

}