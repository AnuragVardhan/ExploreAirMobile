package com.simonshillaker.explore.core
{
	public class PageInfo
	{
		public var title:String;
		public var info:String;
		public var sourceUrl:String;
		
		public function PageInfo(title:String, info:String, sourceUrl:String = null)
		{
			this.title = title;
			this.info = info;
			this.sourceUrl = sourceUrl;
		}
	}
}