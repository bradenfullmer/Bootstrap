package Wizard.wagent.states 
{
	import Wizard.wagent.AgentW
	public class IdleStateW implements IAgentStateW
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(w:AgentW):void
		{
			if (w.numCycles > 70) {
				w.setState(AgentW.WANDER);
			}
		}
		
		public function enter(w:AgentW):void
		{
			w.say("Idling...");
			w.speed = 0;
		}
		
		public function exit(w:AgentW):void
		{
			w.randomDirection();
		}
		
	}

}