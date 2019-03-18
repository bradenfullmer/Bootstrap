package Skeleton.sagent.states  
{
	import Skeleton.sagent.AgentS;
	/**
	 * ...
	 * @author Andreas Rønning
	 */
	public class AttackStateS implements IAgentStateS
	{
		public function AttackStateS() 
		{
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(s:AgentS):void
		{
			if (s.numCycles < 10) return;
			s.say("DIE!");
			s.speed = 0;
			s.faceMouse( 1);
			if (s.distanceToMouse > s.meleeRadius) {
				s.setState(AgentS.FLEE);
			}
			
		}
		
		public function enter(s:AgentS):void
		{
			s.say("Fine");
			s.faceMouse(1);
			s.speed = 0;
		}
		
		public function exit(s:AgentS):void
		{
			
		}
		
	}

}