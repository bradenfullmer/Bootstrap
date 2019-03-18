package Zombie.zagent.states 
{
	import Zombie.zagent.ZAgent;
	
	public interface IAgentStateZ 
	{
		function update(a:ZAgent):void;
		function enter(a:ZAgent):void;
		function exit(a:ZAgent):void;
	}
	
}