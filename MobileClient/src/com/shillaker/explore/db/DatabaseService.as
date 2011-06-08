package com.shillaker.explore.db
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;

	[Event(name="dbError", type="flash.events.SQLErrorEvent")]
	public class DatabaseService extends EventDispatcher
	{
		public static const DB_ERROR:String = "dbError";
		
		private static const GET_ALL_USERS_SQL:String = "select * from user";
		
		private static const CREATE_USER_TABLE_SQL:String = "create table if not exists user " +
			"(user_id integer primary key autoincrement, " +
			"username varchar(20), " +
			"name varchar(50), " +
			"email varchar(50))";
		
		private static const DELETE_ALL_USERS_SQL:String = "delete from user";
		
		private static const CREATE_USER_SQL:String =  "insert into user (username, name, email) values(?, ?, ?)"; 
		
		[Bindable]
		public var initialised:Boolean = false;
		
		[Bindable]
		public var users:ArrayCollection;
		
		private var sqlConnection:SQLConnection;
		
		private var getAllUsersStatement:SQLStatement;
		private var createUserStatement:SQLStatement;
		private var createUserTableStatement:SQLStatement;
		private var deleteAllUsersStatement:SQLStatement;
		
		private var databaseFile:File;
		
		public function DatabaseService()
		{
			databaseFile = File.applicationStorageDirectory.resolvePath("exploreAir.db")	
			sqlConnection = new SQLConnection();
			sqlConnection.open(databaseFile);
			
			getAllUsersStatement = new SQLStatement();
			getAllUsersStatement.sqlConnection = sqlConnection;
			getAllUsersStatement.text = GET_ALL_USERS_SQL;
			getAllUsersStatement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);
			getAllUsersStatement.addEventListener(SQLEvent.RESULT, handleGetAllUsersResult);
			
			createUserStatement = new SQLStatement();
			createUserStatement.sqlConnection = sqlConnection;
			createUserStatement.text = CREATE_USER_SQL;
			createUserStatement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);
			createUserStatement.addEventListener(SQLEvent.RESULT, handleUserCreated);
			
			createUserTableStatement = new SQLStatement();
			createUserTableStatement.sqlConnection = sqlConnection;
			createUserTableStatement.text = CREATE_USER_TABLE_SQL;
			createUserTableStatement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);
			createUserTableStatement.addEventListener(SQLEvent.RESULT, handleDbCreationEvent);
			
			deleteAllUsersStatement = new SQLStatement();
			deleteAllUsersStatement.sqlConnection = sqlConnection;
			deleteAllUsersStatement.text = DELETE_ALL_USERS_SQL;
			deleteAllUsersStatement.addEventListener(SQLEvent.RESULT, handleAllUsersDeleted);
			deleteAllUsersStatement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);

			createUsersTable();
		}
		
		public function deleteAllUsers():void
		{
			deleteAllUsersStatement.execute();
		}
		
		protected function handleAllUsersDeleted(event:SQLEvent):void
		{
			refreshUsers();	
		}
		
		private function createUsersTable():void
		{
			createUserTableStatement.execute();
		}
		
		private function handleDbCreationEvent(event:SQLEvent):void
		{
			initialised = true;
			refreshUsers();
		}
		
		public function refreshUsers():void
		{
			getAllUsersStatement.execute();
		}
		
		protected function handleGetAllUsersResult(event:SQLEvent):void
		{
			users = transformResultIntoUsers(getAllUsersStatement.getResult());
		}
		
		protected function handleSQLError(event:SQLErrorEvent):void
		{
			if(!initialised)
			{
				initialised = true;
			}

			dispatchEvent(event);
		}
		
		public function createUser(user:User):void
		{
			createUserStatement.clearParameters();
			createUserStatement.parameters[0] = user.username;
			createUserStatement.parameters[1] = user.name;
			createUserStatement.parameters[2] = user.email;
			
			createUserStatement.execute();
		}
		
		protected function handleUserCreated(event:SQLEvent):void
		{
			refreshUsers();
		}
		
		private function transformResultIntoUsers(sqlResult:SQLResult):ArrayCollection 
		{
			if(!sqlResult)
			{
				return null;
			}
			
			var resultArray:Array;
			resultArray = sqlResult.data as Array;		
			
			var users:ArrayCollection = new ArrayCollection();
			
			if(!resultArray) 
			{
				return users;
			}
			
			for(var i:int = 0; i < resultArray.length; i++)
			{
				var user:User = new User();
				user.userId = resultArray[i].user_id;
				user.username = resultArray[i].username;
				user.name = resultArray[i].name;
				user.email = resultArray[i].email;
				
				users.addItem(user);
			}
			
			return users;
		}
	}
}