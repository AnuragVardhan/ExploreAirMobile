package com.simonshillaker.explore.localdb
{
	import flash.text.TextField;
	
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	
	import spark.components.Label;
	
	public class UserRenderer extends UIComponent implements IDataRenderer
	{
		private static const LABEL_HEIGHT:int = 20;
		private static const PADDING:int = 5;
		private static const RENDERER_HEIGHT:int = 80;
		
		protected var _data:Object;
		
		protected var idLabel:Label;
		protected var usernameLabel:Label;
		protected var nameLabel:Label;
		
		////////////////////////////////////
		//    UIComponent methods
		////////////////////////////////////

		override protected function measure():void
		{
			measuredHeight = RENDERER_HEIGHT;
		}
		
		override protected function createChildren():void
		{
			idLabel = new Label();
			usernameLabel = new Label();
			nameLabel = new Label();
			
			addChild(idLabel);
			addChild(usernameLabel);
			addChild(nameLabel);

			if(data)
			{
				assignDataToLabels();
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			idLabel.x = PADDING;
			usernameLabel.x = PADDING;
			nameLabel.x = PADDING;
			
			idLabel.y = PADDING;
			usernameLabel.y = 2*PADDING + LABEL_HEIGHT;
			nameLabel.y = 3*PADDING + 2*LABEL_HEIGHT;
			
//			drawDividerAtBottom(unscaledWidth, unscaledHeight - 1);
		}
		
		/////////////////////////////////////////
		//     IDataRenderer methods
		/////////////////////////////////////////
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			
			if(idLabel && usernameLabel && nameLabel)
			{
			 	assignDataToLabels();
			}
			
		}
		
		private function assignDataToLabels():void
		{
			idLabel.text = data["userId"];
			usernameLabel.text = data["username"];
			nameLabel.text = data["name"];
			
		}
		private function drawDividerAtBottom(width:Number, baseY:Number):void
		{
			graphics.clear();
			graphics.lineStyle(1);
			graphics.moveTo(0, baseY);
			graphics.lineTo(width, baseY);
		}
		
	}
}