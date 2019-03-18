package Wizard.wagent.states 
{
	import Wizard.wagent.AgentW;
	public class AwayFromWallW implements IAgentStateW
	{
		
		public function update(w:AgentW):void
		{//instead of the random, the velocity should be going away from the wall... 
			w.say("Avoiding the wall...");
			
			if (w.numCycles > 25) {
				w.setState(AgentW.IDLE);
				w.setState(AgentW.IDLE);
			}
		}
		
		public function enter(w:AgentW):void
		{
			w.speed = .8;
		}
		
		public function exit(w:AgentW):void
		{
			w.speed = .6;
		}
	}
}