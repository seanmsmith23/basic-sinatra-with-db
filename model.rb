def finds_name(user_id)
  username = @database_connection.sql("SELECT username FROM users WHERE id = #{user_id}")
  username.pop["username"]
end

def username_and_password(username, password)
  if username == "" and password == ""
    flash[:error] = "No username or password provided"
  elsif username == ""
    flash[:error] = "No username provided"
  elsif password == ""
    flash[:error] = "No password provided"
  else
  end
end