package Skeleton.sagent.states 
{
	import Skeleton.sagent.AgentS;
	public class WanderStateS implements IAgentStateS
	{
		
		public function update(s:AgentS):void
		{
			s.say("Wandering...");
			s.velocity.x += Math.random() * 0.2 - 0.1;
			s.velocity.y += Math.random() * 0.2 - 0.1;
			if (s.numCycles > 120) {
				s.setState(AgentS.IDLE);
				s.setState(AgentS.IDLE);
			}
			if (!s.canSeeMouse) return;
			if (s.distanceToMouse < s.fleeRadius) {
				s.setState(AgentS.FLEE);
			}else if (s.distanceToMouse < s.chaseRadius) {
				s.setState(AgentS.CHASE);
			}
		}
		
		public function enter(s:AgentS):void
		{
			s.speed = .8;
		}
		
		public function exit(s:AgentS):void
		{
			
		}
	}
}