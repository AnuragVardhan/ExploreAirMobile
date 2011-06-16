package com.simonshillaker.explore.localdb
{
	public class UserSQL
	{
		internal static const GET_ALL_USERS_SQL:String = "select * from user";
		
		internal static const CREATE_USER_TABLE_SQL:String = 
			"create table if not exists user " +
			"(user_id integer primary key autoincrement, " +
			"username varchar(20), " +
			"name varchar(50))";
		
		internal static const DELETE_ALL_USERS_SQL:String = "delete from user";
		
		internal static const CREATE_USER_SQL:String =  
			"insert into user (username, name) values(?, ?)"; 
		
	}
}