package com.shillaker.explore.db
{
	import mx.rpc.xml.SimpleXMLEncoder;

	[Bindable]
	public class User
	{
		public var userId:Number;
		public var username:String;
		public var name:String;
		public var email:String;
	
		public static function instanceFromXML(xml:XML):User 
		{
			var user:User = new User();
			user.userId = xml..userId;
			user.email = xml..email;
			user.name = xml..name;
			user.username = xml..username;
			
			return user;
		}
		
		public function User()
		{
		}

		public function toXML():XML {
			var xmlString:String = "<userDto>" +
				"<userId>" + userId + "</userId>" +
				"<username>" + username + "</username>" + 
				"<name>" + name + "</name>" + 
				"<email>" + email + "</email>" + 
				"</userDto>";
		
			return new XML(xmlString);
		}
		
	}
}