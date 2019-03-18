package  Maze
{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.MovieClip;
	

	public class Stairs extends MovieClip {
		
		var setPlayerStartX:int;
		var setPlayerStartY:int;
		
		var txtLoader:URLLoader = new URLLoader();
		var mazeItem:String=new String();

		var row:Array = new Array();
		var col:Array = new Array();
		var char:String = new String();
		var num:int = new Number();
		
		public function Stairs(floorLevel)
		{
			var urlReq:URLRequest = new URLRequest("Maze/"+floorLevel+".txt");
			
			txtLoader.addEventListener(Event.COMPLETE, onLoadText);
			txtLoader.load(urlReq);
		}
		
		public function onLoadText(evt:Event) {
			
				
			
			mazeItem=txtLoader.data;
			row = mazeItem.split(/\n/);

			for (var i:int=0; i<row.length; i++)
			{
				
				col.splice(0);
				
				col = row[i].split("");
				
				for (var j:int=0; j<col.length-1; j++)
				{
					char="";
					char=col[j];
					num=parseInt(char);
					

					if(num==2 || num == 3)//else
					{
						var se:stairs_Element = new stairs_Element();

						se.x=1+j*se.width;
						se.y=1+i*se.height;
						
						trace(se.x, se.y);
						
						if (num==2)
						{
							var setPlayerStartX:int = se.x;
							var setPlayerStartY:int = se.y;
							
						}
						
						addChild(se);
						
					}
					
				}
			}
			
			
		}
			public function get startPlayerX():int
			{
				return setPlayerStartX;
			}
			public function get startPlayerY():int
			{
				return setPlayerStartY;
			}
	}
	
}
