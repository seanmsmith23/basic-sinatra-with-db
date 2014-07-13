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
    asc = params[:asc]
    p "ASC #{asc.inspect}"
    desc = params[:desc]
    p "DESC #{desc.inspect}"
    p "ORDER CHECK #{check_for_order(asc, desc).inspect}"
    if session[:user_id]
      erb :homepage2, locals: {:name => finds_name(session[:user_id]),
                               :users_data => username_id_hashes(check_for_order(asc, desc)),
                               :users_fish_data => user_fish_data(session[:user_id])}
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

  get "/fish_factory" do
    erb :fish
  end

  post "/fish_factory" do
    fish = params[:fishname]
    wiki = params[:wiki]
    insert_fish(fish, wiki)
    redirect '/'
  end

  get "/logout" do
    session.delete(:user_id)
    redirect '/'
  end

  get "/user/:username" do
    user = params[:username]
    erb :user_page, locals: { :user => user, :fish_data => users_fish_list(user) }
  end

end
