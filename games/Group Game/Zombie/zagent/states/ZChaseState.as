package Zombie.zagent.states 
{
	import Zombie.zagent.ZAgent;
	public class ZChaseState implements IAgentStateZ
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:ZAgent):void
		{
			var dx:Number = a.ztarget.x - a.x;
			var dy:Number = a.ztarget.y - a.y;
			var rad:Number = Math.atan2(dy, dx);
			a.velocity.x = Math.cos(rad);
			a.velocity.y = Math.sin(rad);
			if (a.numCycles < 40) return;
			a.say("Following");
			a.speed = .75;
			if (a.distanceToMouse > a.chaseRadius) {
				a.setState(ZAgent.CONFUSED);
			}
			if (a.distanceToMouse < a.AttackRadius) {
				a.setState(ZAgent.ATTACK);
			}
		}
		
		public function enter(a:ZAgent):void
		{
			var dx:Number = a.ztarget.x - a.x;
			var dy:Number = a.ztarget.y - a.y;
			var rad:Number = Math.atan2(dy, dx);
			a.velocity.x = Math.cos(rad);
			a.velocity.y = Math.sin(rad);
			a.say("Food?");
			a.speed = 0;
		}
		
		public function exit(a:ZAgent):void
		{
			
		}
		
	}

}