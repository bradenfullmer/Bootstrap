package Zombie.zagent.states 
{
	import Zombie.zagent.ZAgent;
	/**
	 * ...
	 * @author Andreas Rønning
	 */
	public class ZAttackState implements IAgentStateZ, IAgentAttackZ
	{
		public var damage:Number;
		
		
		
		
		public function ZAttackState(){
			
			
			
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:ZAgent):void
		{
			if (a.numCycles < 10) return;
			a.say("Nom!");
			a.speed = 0;
			a.faceMouse( 1);
			if(a.numCycles>10){
				if (a.distanceToMouse > a.AttackRadius) {
					a.setState(ZAgent.CHASE);
				}
				
			}
			
		}
		
		public function enter(a:ZAgent):void
		{
			a.say("FOOD!");
			a.faceMouse(1);
			a.speed = 0;
		}
		
		public function exit(a:ZAgent):void
		{
			
		}
		public function attack(a:ZAgent):void
		{
			
		}
			
	}

}