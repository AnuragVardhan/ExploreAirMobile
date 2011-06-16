package com.simonshillaker.explore.localdb
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	public class UserDao extends EventDispatcher
	{
		[Bindable]
		public var initialised:Boolean = false;
		
		[Bindable]
		public var users:ArrayCollection;
		
		[Bindable]
		public var errorText:String;
		
		private var sqlConnection:SQLConnection;
		
		private var getAllUsersStatement:SQLStatement;
		private var createUserStatement:SQLStatement;
		private var createUserTableStatement:SQLStatement;
		private var deleteAllUsersStatement:SQLStatement;
		
		private var databaseFile:File;
		
		public function UserDao()
		{
			databaseFile = File.applicationStorageDirectory.resolvePath("exploreAir.db")	
			sqlConnection = new SQLConnection();
			sqlConnection.openAsync(databaseFile);

			sqlConnection.addEventListener(SQLEvent.OPEN, handleSQLConnectionOpen);
			
			getAllUsersStatement = new SQLStatement();
			getAllUsersStatement.sqlConnection = sqlConnection;
			getAllUsersStatement.text = UserSQL.GET_ALL_USERS_SQL;
			getAllUsersStatement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);
			getAllUsersStatement.addEventListener(SQLEvent.RESULT, handleGetAllUsersResult);
			
			createUserStatement = new SQLStatement();
			createUserStatement.sqlConnection = sqlConnection;
			createUserStatement.text = UserSQL.CREATE_USER_SQL;
			createUserStatement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);
			createUserStatement.addEventListener(SQLEvent.RESULT, refreshUsers);
			
			createUserTableStatement = new SQLStatement();
			createUserTableStatement.sqlConnection = sqlConnection;
			createUserTableStatement.text = UserSQL.CREATE_USER_TABLE_SQL;
			createUserTableStatement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);
			createUserTableStatement.addEventListener(SQLEvent.RESULT, handleUserTableCreated);
			
			deleteAllUsersStatement = new SQLStatement();
			deleteAllUsersStatement.sqlConnection = sqlConnection;
			deleteAllUsersStatement.text = UserSQL.DELETE_ALL_USERS_SQL;
			deleteAllUsersStatement.addEventListener(SQLErrorEvent.ERROR, handleSQLError);
			deleteAllUsersStatement.addEventListener(SQLEvent.RESULT, refreshUsers);

		}
		
		// PUBLIC METHODS
		
		public function deleteAllUsers():void
		{
			try {
				deleteAllUsersStatement.execute();
			} 
			catch (ex:SQLError)
			{
				errorText = ex.details;	
			}
		}
		
		public function createUser(user:User):void
		{
			createUserStatement.clearParameters();
			createUserStatement.parameters[0] = user.username;
			createUserStatement.parameters[1] = user.name;
			
			createUserStatement.execute();
		}
		
		public function dispose():void
		{
			sqlConnection.close();
			
			getAllUsersStatement = null;
			createUserStatement = null;
			createUserTableStatement = null;
			deleteAllUsersStatement = null;
		}
		
		// PRIVATE METHODS
		
		private function handleSQLConnectionOpen(event:SQLEvent):void
		{
			sqlConnection.removeEventListener(SQLEvent.OPEN, handleSQLConnectionOpen);
			createUserTableStatement.execute();
		}
		
		private function handleUserTableCreated(event:SQLEvent):void
		{
			initialised = true;
			refreshUsers();
		}
		
		private function refreshUsers(...rest):void
		{
			errorText = "";
			getAllUsersStatement.execute();
		}
		
		private function handleGetAllUsersResult(event:SQLEvent):void
		{
			var sqlResult:SQLResult = getAllUsersStatement.getResult();
			users = transformResultIntoUsers(sqlResult);
		}
		
		private function handleSQLError(event:SQLErrorEvent):void
		{
			if(!initialised)
			{
				initialised = true;
			}
			
			errorText = 
				resourceManager.getString('explore_air_mobile', 'local_db_sql_error_message') + 
				" " + event.error.details;
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
			
			for(var i:int = 0; i < resultArray.length; i++)
			{
				var user:User = new User();
				user.userId = resultArray[i].user_id;
				user.username = resultArray[i].username;
				user.name = resultArray[i].name;
				
				users.addItem(user);
			}
			
			return users;
		}
		
		private function get resourceManager():IResourceManager
		{
			return ResourceManager.getInstance();
		}
	}
}