package Skeleton.sagent.states 
{
	import Skeleton.sagent.AgentS;
	public class ChaseStateS implements IAgentStateS
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(s:AgentS):void
		{
			var dx:Number = s.starget.x - s.x;
			var dy:Number = s.starget.y - s.y;
			var rad:Number = Math.atan2(dy, dx);
			s.velocity.x = Math.cos(rad);
			s.velocity.y = Math.sin(rad);
			if (s.numCycles < 40) return;
			s.say("Chasing!");
			s.speed = 1.5;
			if (s.distanceToMouse > s.chaseRadius) {
				s.setState(AgentS.CONFUSED);
			}
			if (s.distanceToMouse < s.shootRadius) {
				s.setState(AgentS.SHOOT);
			}
		}
		
		public function enter(s:AgentS):void
		{
			var dx:Number = s.starget.x - s.x;
			var dy:Number = s.starget.y - s.y;
			var rad:Number = Math.atan2(dy, dx);
			s.velocity.x = Math.cos(rad);
			s.velocity.y = Math.sin(rad);
			s.say("Oh wow! Something to chase!");
			s.speed = 0;
		}
		
		public function exit(s:AgentS):void
		{
			
		}
		
	}

}