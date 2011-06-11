package com.shillaker.explore.springmvc
{
	import flash.events.Event;
	
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class ServerConnector
	{
		private static var instance : ServerConnector;
		
		private static var SERVER_URL:String = 'http://localhost:8080/spring-webapp/linkup/';
		
		public static function getInstance() : ServerConnector {
			if( instance == null )
				instance = new ServerConnector();
			return instance;
		}
		
		public function doServerConnectorCall( url : String, 
											   resultFunction : Function, 
											   faultFunction : Function = null,
											   serverConnectorMethod : String = 'GET', 
											   parms : Object = null ) : void
		{
			var httpService : HTTPService = new HTTPService( );
			
			switch (serverConnectorMethod) 
			{
				case 'GET':
					httpService.method = HTTPRequestMessage.GET_METHOD;
					break;
				case 'POST':
					httpService.method = HTTPRequestMessage.POST_METHOD;
					break;
				default:
					httpService.method = HTTPRequestMessage.PUT_METHOD;
					break;
			}
			
			httpService.url = SERVER_URL + url;
			httpService.resultFormat = 'e4x';
			
			if(parms != null) {
				httpService.contentType = 'application/xml';
			}
			
			httpService.addEventListener( ResultEvent.RESULT, resultFunction );
			
			if( faultFunction != null )
			{
				httpService.addEventListener( FaultEvent.FAULT, faultFunction );
			}
			
			httpService.send( parms );
		}
	}
	
}