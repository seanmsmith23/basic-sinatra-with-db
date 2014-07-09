def finds_name(user_id)
  username = @database_connection.sql("SELECT username FROM users WHERE id = #{user_id}")
  username.pop["username"]

end