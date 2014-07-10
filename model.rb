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

def login_user_create_session(username, password)
  if username == "" || password == ""
  username_and_password(username, password)
  redirect '/'
  else
    data_name = @database_connection.sql("SELECT * FROM users WHERE username = '#{username}'")
    data_name.each do |hash|
      if hash["username"] == username && hash["password"] == password
        session[:user_id] = hash["id"].to_i
      else
        flash[:error] = "Username and Password not found"
      end
    end
    redirect '/'
  end
end

def user_registration(username, password)
  if username == "" || password == ""
    username_and_password(username, password)
    redirect '/registration'
  else
    begin
      @database_connection.sql("INSERT INTO users (username, password) VALUES ('#{username}', '#{password}')")
      flash[:notice] = "Thank you for registering"
    rescue
      flash[:error] = "This user already exists"
      redirect '/'
    end
  end
end