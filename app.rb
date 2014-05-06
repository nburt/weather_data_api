require 'sinatra/base'
require './lib/open_weather_search'

class App < Sinatra::Application

  get '/' do
    open_weather_search = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
    temp_hash = open_weather_search.get_temperature('Denver', 'CO')
    erb :index, :locals => {:temp_hash => temp_hash, :city => 'Denver', :state => 'CO'}
  end

end