require "sinatra"
require "active_record"
require "./lib/database_connection"
require_relative "model"

class App < Sinatra::Application
  def initialize
    super
    @database_connection = DatabaseConnection.new(ENV["RACK_ENV"])
  end

  get "/" do
    erb :homepage
  end
end
