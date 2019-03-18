package Zombie.zagent.states 
{
	import Zombie.zagent.ZAgent;
	public class ZWanderState implements IAgentStateZ
	{
		
		public function update(a:ZAgent):void
		{
			a.say("Wandering...");
			a.velocity.x += Math.random() * 0.2 - 0.1;
			a.velocity.y += Math.random() * 0.2 - 0.1;
			if (a.numCycles > 120) {
				a.setState(ZAgent.IDLE);
			}
			if (!a.canSeeMouse) return;
			if (a.distanceToMouse < a.AttackRadius) {
				a.setState(ZAgent.ATTACK);
			}else if (a.distanceToMouse < a.chaseRadius) {
				a.setState(ZAgent.CHASE);
			}
		}
		
		public function enter(a:ZAgent):void
		{
			a.speed = .25;
		}
		
		public function exit(a:ZAgent):void
		{
			
		}
	}
}