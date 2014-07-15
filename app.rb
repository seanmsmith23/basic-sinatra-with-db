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
    desc = params[:desc]

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

  post "/delete_user" do
    user_to_delete = params[:delete_user]
    p "USER TO DELETE #{user_to_delete}"
    delete_user_from_db(user_to_delete)
    redirect "/"
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
    erb :new_fish
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
    erb :user_page, locals: { :user => user,
                              :fish_data => users_fish_list(user),
                              :user_favorites => current_user_favorites}
  end

  post "/fish/favorited" do
    owner_id = params[:fish_owner]
    fishname = params[:fish]

    add_favorite(fishname, owner_id)

    redirect back
  end

  post "/fish/rm_favorite" do
    owner_id = params[:fish_owner]
    fishname = params[:fish]

    remove_favorite(fishname, owner_id)

    redirect back
  end

end
