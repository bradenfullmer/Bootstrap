package Wizard.wagent.states 
{
	import Wizard.wagent.AgentW;
	public class ChaseStateW implements IAgentStateW
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(w:AgentW):void
		{
			var dx:Number = w.wtarget.x - w.x;
			var dy:Number = w.wtarget.y - w.y;
			var rad:Number = Math.atan2(dy, dx);
			w.velocity.x = Math.cos(rad);
			w.velocity.y = Math.sin(rad);
			if (w.numCycles < 40) return;
			w.say("Chasing!");
			w.speed = .8;
			if (w.distanceToMouse > w.chaseRadius) {
				w.setState(AgentW.WANDER);
			}
			if (w.distanceToMouse < w.shootRadius) {
				w.setState(AgentW.SHOOT);
			}
		}
		
		public function enter(w:AgentW):void
		{
			var dx:Number = w.wtarget.x - w.x;
			var dy:Number = w.wtarget.y - w.y;
			var rad:Number = Math.atan2(dy, dx);
			w.velocity.x = Math.cos(rad);
			w.velocity.y = Math.sin(rad);
			w.say("Oh wow! Something to chase!");
			w.speed = 0;
		}
		
		public function exit(w:AgentW):void
		{
			
		}
		
	}

}