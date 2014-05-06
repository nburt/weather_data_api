require 'sinatra/base'
require './lib/open_weather_search'

class App < Sinatra::Application

  get '/' do
    open_weather_search = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
    temperature_type = 'F'
    temp_hash = open_weather_search.get_temperature('Denver', 'CO', temperature_type)
    erb :index, :locals => {:temp_hash => temp_hash, :city => 'Denver', :state => 'CO', :temperature_type => temperature_type}
  end

end