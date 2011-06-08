package com.shillaker.explore.db
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;

	public class DatabaseService
	{
		[Bindable]
		public var initialised:Boolean = false;

		[Bindable]
		public var errorMessage:String = "";
		
		private var sqlConnection:SQLConnection;

		private var databaseFile:File;
		
		public function DatabaseService()
		{
			databaseFile = File.applicationStorageDirectory.resolvePath("exploreAir.db")	
			sqlConnection = new SQLConnection();
			sqlConnection.open(databaseFile);
		}
		
		private function createUsersTable():void
		{
			var statement:SQLStatement = new SQLStatement;
			statement.sqlConnection = sqlConnection;
			
			statement.text = "create table if not exists user " +
				"(user_id integer primary key autoincrement, " +
				"username varchar(20), " +
				"name varchar(50), " +
				"email varchar(50))";
			
			statement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);
			
			statement.execute();
		}
		
		public function getAllUsers():void
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = sqlConnection;
			statement.text = "select * from user";
			statement.execute();
			
			statement.addEventListener(SQLEvent.RESULT, handleGetAllUsersResult);
			statement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);
		}
		
		protected function handleSQLError(event:SQLErrorEvent):void
		{
			errorMessage = event.error.details;
		}
		
		protected function handleGetAllUsersResult(event:SQLEvent):void
		{
			trace("Get all users result");
		}
		
		
		public function createUser(user:User) 
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = sqlConnection;
			statement.text = "insert into user (username, name, email)" +
			"values(?, ?, ?)";
			statement.parameters[0] = user.username;
			statement.parameters[1] = user.name;
			statement.parameters[2] = user.email;
			
			statement.execute();
		}
	}
}