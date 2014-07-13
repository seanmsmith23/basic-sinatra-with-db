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
      redirect '/'
    rescue
      flash[:error] = "This user already exists"
      redirect '/'
    end
  end
end

def username_id_hashes
  users_data =  @database_connection.sql("SELECT username, id FROM users")
  # usernames =  users.map do |u|
  #   if session[:user_id] != u["id"].to_i
  #     "<a href='/user/#{u["username"]}'><li>" + u["username"] + "</li></a>"
  #   end
  # end
end

def insert_fish(fishname, wiki)
  @database_connection.sql("INSERT INTO fish (fishname, wiki_link, user_id) VALUES ('#{fishname}', '#{wiki}', '#{session[:user_id]}')")
end

def fish_list(id)
  fish_data = @database_connection.sql("SELECT fishname, wiki_link, user_id FROM fish;")
  list = fish_data.map do |fish_hash|
    if id == fish_hash["user_id"].to_i
    "<li><a href='#{fish_hash["wiki_link"]}'>#{fish_hash["fishname"]}</a></li>"
    end
  end

  list.join
end

def users_fish_list(name)
  user = @database_connection.sql("SELECT id FROM users WHERE username = '#{name}';")
  fish_data = @database_connection.sql("SELECT fishname, wiki_link, user_id FROM fish;")
  user_hash = user.pop
  list = fish_data.map do |fish_hash|
    if user_hash["id"] == fish_hash["user_id"]
      "<li><a href='#{fish_hash["wiki_link"]}'>#{fish_hash["fishname"]}</a></li>"
    end
  end
  list.join
end