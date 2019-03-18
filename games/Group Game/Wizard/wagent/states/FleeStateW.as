package Wizard.wagent.states  
{
	import Wizard.wagent.AgentW;
	/**
	 * ...
	 * @author Andreas Rønning
	 */
	public class FleeStateW implements IAgentStateW
	{
		public var shootCounter:int = 0;		
		public var shootAttack:Number;
		public function FleeStateW() 
		{
			shootAttack = 10;
		}
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(w:AgentW):void
		{
			shootCounter++
			if (w.numCycles < 10) return;
			w.say("Fleeing!");
			w.speed = -.6;
			w.faceMouse( 1);
			if (w.distanceToMouse > w.fleeRadius) {
				w.setState(AgentW.SHOOT);
				shootCounter = 0;
			}
			if (shootCounter >40){
				trace ("Pew!");
				shootCounter = 0;

			}
		}
		
		public function enter(w:AgentW):void
		{
			w.say("Eek!");
			w.faceMouse(1);
			w.speed = 0;
		}
		
		public function exit(w:AgentW):void
		{
			
		}
		
	}

}