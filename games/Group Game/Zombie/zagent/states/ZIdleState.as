package Zombie.zagent.states 
{
	import Zombie.zagent.ZAgent;
	public class ZIdleState implements IAgentStateZ
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:ZAgent):void
		{
			if (a.numCycles > 30) {
				a.setState(ZAgent.WANDER);
			}
		}
		
		public function enter(a:ZAgent):void
		{
			a.say("Idling...");
			a.speed = 0;
		}
		
		public function exit(a:ZAgent):void
		{
			a.randomDirection();
		}
		
	}

}