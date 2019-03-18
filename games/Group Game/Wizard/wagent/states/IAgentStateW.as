package Wizard.wagent.states 
{
	import Wizard.wagent.AgentW;
	
	public interface IAgentStateW
	{
		function update(w:AgentW):void;
		function enter(w:AgentW):void;
		function exit(w:AgentW):void;
	}
	
}