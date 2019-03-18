package Zombie.zagent.states 
{
	import Zombie.zagent.ZAgent;
	public class ZConfusionState implements IAgentStateZ
	{
		public function ZConfusionState() 
		{
			
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:ZAgent):void
		{
			if (++a.numCycles % 10 == 0) {
				a.randomDirection();
				if (a.canSeeMouse && a.distanceToMouse < a.chaseRadius) {
					if(a.previousState==ZAgent.ATTACK) a.setState(ZAgent.ATTACK);
					if(a.previousState==ZAgent.CHASE) a.setState(ZAgent.CHASE);
				}
			}
			if (a.numCycles > 30) a.setState(ZAgent.IDLE);
		}
		
		public function enter(a:ZAgent):void
		{
			a.say("???");
			a.speed = 0;
		}
		
		public function exit(a:ZAgent):void
		{
			
		}
		
	}

}