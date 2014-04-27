package net.sismicos.hermit.levels 
{
	public class LevelDescription 
	{
		public var data:Class;
		public var text:String;
		public var tutorial:String;
		
		public function LevelDescription(data:Class, text:String, tutorial:String)
		{
			this.data = data;
			this.text = text;
			this.tutorial = tutorial;
		}
	}

}