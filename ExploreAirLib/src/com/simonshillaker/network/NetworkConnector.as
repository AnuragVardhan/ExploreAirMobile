package com.simonshillaker.network
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;

	[Event(name="messageReceived", type="flash.events.NetStatusEvent")]
	public class NetworkConnector extends EventDispatcher
	{
		public static const MESSAGE_RECEIVED:String = "messageReceived";
		
		private var connection:NetConnection;
		
		private var group:NetGroup;
		
		private var isConnected:Boolean = false;
		
		[Bindable]
		public var networkInfoText:String;
		
		public function NetworkConnector()
		{
			connect();
		}

		public function sendMessage(message:String):void
		{
			group.sendToAllNeighbors(message);	
		}
		
		private function connect():void
		{
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatus);
			connection.connect("rtmfp:");
		}
		
		private function netStatus(event:NetStatusEvent):void
		{			
			networkInfoText += event.info.code + "\n";
			
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
					setupGroup();
					break;
				case "NetGroup.Connect.Success":
					break;
				case "NetGroup.SendTo.Notify":
					var newEvent:NetStatusEvent = new NetStatusEvent(MESSAGE_RECEIVED, false, false, event.info);
					dispatchEvent(newEvent);
					break;
				
			}
		}
		
		private function setupGroup():void
		{
			var groupSpec:GroupSpecifier = new GroupSpecifier("localDeviceConnections");
			groupSpec.routingEnabled = true;
			groupSpec.ipMulticastMemberUpdatesEnabled = true;
			groupSpec.addIPMulticastAddress("224.255.0.0:35353");
			groupSpec.multicastEnabled = true;
			
			group = new NetGroup(connection, groupSpec.groupspecWithAuthorizations());
			
			group.addEventListener(NetStatusEvent.NET_STATUS, netStatus);
		}

	}
}