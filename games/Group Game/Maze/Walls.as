package  Maze
{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.InteractiveObject;
	

	public class Walls extends MovieClip {
			public var bumpArray:Array = new Array();

			var txtLoader:URLLoader = new URLLoader();
			var mazeItem:String=new String();
			var row:Array = new Array();
			var col:Array = new Array();
			var char:String = new String();
			var num:int = new Number();
			
		public function Walls(wallLevel:String)
		{
			var urlReq:URLRequest = new URLRequest("Maze/" + wallLevel + ".txt");
			
			txtLoader.addEventListener(Event.COMPLETE, onLoadText);
			txtLoader.load(urlReq);
		}
		
		
		private function onLoadText(evt:Event) {				
			bumpArray = new Array();
			mazeItem=txtLoader.data;
			row = mazeItem.split(/\n/);

			for (var i:int=0; i<row.length+1; i++)
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
						bumpArray.push(we);
						addChild(we);

					}
					
				}
				//displayBumpArray();
			}
			
		}
			private function displayBumpArray():void{
				var i:int=0;
				for each (var wei:wall_Element in bumpArray)
				{
					trace(wei + i++);//129 wall elements
				}
			}
		

	}
	
}
