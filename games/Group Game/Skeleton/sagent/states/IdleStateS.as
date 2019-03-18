package Skeleton.sagent.states 
{
	import Skeleton.sagent.AgentS;
	public class IdleStateS implements IAgentStateS
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(s:AgentS):void
		{
			if (s.numCycles > 30) {
				s.setState(AgentS.WANDER);
			}
		}
		
		public function enter(s:AgentS):void
		{
			s.say("Idling...");
			s.speed = 0;
		}
		
		public function exit(s:AgentS):void
		{
			s.randomDirection();
		}
		
	}

}