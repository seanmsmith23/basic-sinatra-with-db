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
    @database_connection = DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    if session[:user_id]
      erb :homepage2, locals: {:name => finds_name(session[:user_id]), :list_of_users => list_of_users}
    else
      erb :homepage
    end

  end

  post "/" do
    username = params[:username]
    password = params[:password]

    login_user_create_session(username, password)
  end

  get "/registration" do
    erb :registration
  end

  post "/registration"  do
    username = params[:username]
    password = params[:password]

    user_registration(username, password)
  end

  get "/logout" do
    session.delete(:user_id)
    redirect '/'
  end

end
