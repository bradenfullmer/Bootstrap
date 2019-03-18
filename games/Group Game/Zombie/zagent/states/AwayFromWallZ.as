package Zombie.zagent.states
{
	import Zombie.zagent.ZAgent
	public class AwayFromWallZ implements IAgentStateZ
	{
		
		
		
		public function update(w:ZAgent):void
		{
			w.say("Avoiding the wall...");
			//instead of the random, the velocity should be going away from the wall... 
		

			w.speed = .25;
			if (w.numCycles > 5) {
				w.setState(ZAgent.WANDER);
				w.setState(ZAgent.WANDER);
			}
		}
		
		public function enter(w:ZAgent):void
		{
			
			w.speed = .25;
		}
		
		public function exit(w:ZAgent):void
		{
			w.randomDirection();
		}
		
	}

}