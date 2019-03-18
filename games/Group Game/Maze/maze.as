package  Maze
{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.MovieClip;
	

	public class maze extends MovieClip {
			var txtLoader:URLLoader = new URLLoader();
			var mazeItem:String=new String();

			var row:Array = new Array();
			var col:Array = new Array();
			var char:String = new String();
			var num:int = new Number();
		
		public function maze(callLevel)
		{
			var urlReq:URLRequest = new URLRequest("Maze/" + callLevel + ".txt");
			
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
					

					if(num==1)
					{
						var we:wall_Element = new wall_Element();

						we.x=0+j*we.width;
						we.y=0+i*we.height;
						addChild(we);
					}
					else
					{
						var fe:floor_Element = new floor_Element();

						fe.x=1+j*fe.width;
						fe.y=1+i*fe.height;
						addChild(fe);
						
					}
					
				}
			}
			
			
		}
	}
	
}
