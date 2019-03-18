package Skeleton.sagent.states  
{
	import Skeleton.sagent.AgentS;
	/**
	 * ...
	 * @author Andreas Rønning
	 */
	public class ShootStateS implements IAgentStateS
	{
		public function ShootStateS(){
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(s:AgentS):void
		{
			if (s.numCycles < 10) return;
			s.say("DIE!");
			s.speed = 0;
			s.faceMouse( 1);
			if (s.distanceToMouse > s.shootRadius) {
				s.setState(AgentS.CHASE);
			}
			if (s.distanceToMouse < s.fleeRadius) {
				s.setState(AgentS.FLEE);
			}
			
		}
		
		public function enter(s:AgentS):void
		{
			s.say("DIE!");
			s.faceMouse(1);
			s.speed = 0;
		}
		
		public function exit(s:AgentS):void
		{
			
		}
		
	}

}