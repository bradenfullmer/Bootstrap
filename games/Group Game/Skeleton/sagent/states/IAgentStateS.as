package Skeleton.sagent.states 
{
	import Skeleton.sagent.AgentS;
	
	public interface IAgentStateS
	{
		function update(s:AgentS):void;
		function enter(s:AgentS):void;
		function exit(s:AgentS):void;
	}
	
}