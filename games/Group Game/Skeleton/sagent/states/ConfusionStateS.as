package Skeleton.sagent.states 
{
	import Skeleton.sagent.AgentS;
	public class ConfusionStateS implements IAgentStateS
	{
		public function ConfusionStateS() 
		{
			
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(s:AgentS):void
		{
			if (++s.numCycles % 10 == 0) {
				s.randomDirection();
				if (s.canSeeMouse && s.distanceToMouse < s.chaseRadius) {
					if(s.previousState==AgentS.FLEE) s.setState(AgentS.FLEE);
					if(s.previousState==AgentS.CHASE) s.setState(AgentS.CHASE);
				}
			}
			if (s.numCycles > 60) s.setState(AgentS.IDLE);
		}
		
		public function enter(s:AgentS):void
		{
			s.say("???");
			s.speed = 0;
		}
		
		public function exit(a:AgentS):void
		{
			
		}
		
	}

}