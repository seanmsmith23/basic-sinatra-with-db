require "sinatra"
require "active_record"
require "./lib/database_connection"
require "rack-flash"
require_relative "model"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = DatabaseConnection.new(ENV["RACK_ENV"])
  end

  get "/" do
    if session[:user_id]
      erb :homepage2, locals: {:name => finds_name(session[:user_id]), :id => session[:user_id] }
    else
      erb :homepage
    end

  end

  post "/" do
    username = params[:username]
    password = params[:password]
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

  get "/registration" do
    erb :registration
  end

  post "/registration"  do
    username = params[:username]
    password = params[:password]

    if username == "" || password == ""
      username_and_password(username, password)
      redirect '/registration'
    else
      @database_connection.sql("INSERT INTO users (username, password) VALUES ('#{username}', '#{password}')")
      flash[:notice] = "Thank you for registering"
      redirect '/'
    end
  end

  get "/logout" do
    session.delete(:user_id)
    redirect '/'
  end

end
