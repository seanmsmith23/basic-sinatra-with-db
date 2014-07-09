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
    erb :homepage
  end

  get "/registration" do
    erb :registration
  end

  post "/registration"  do
    flash[:notice] = "Thank you for registering"
    redirect '/'
  end

end
