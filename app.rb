require 'sinatra/base'
require './lib/open_weather_search'

class App < Sinatra::Application

  enable :sessions

  get '/' do
    erb :index
  end

  post '/' do
    open_weather_search = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
    temp_hash = open_weather_search.get_temperature(params[:city], params[:state], params[:temperature_type])
    session[:temp_hash] = temp_hash
    session[:city] = params[:city]
    session[:state] = params[:state]
    session[:temperature_type] = params[:temperature_type]
    redirect '/weather'
  end

  get '/weather' do
    erb :weather, :locals => {:temp_hash => session[:temp_hash], :city => session[:city], :state => session[:state], :temperature_type => session[:temperature_type]}
  end

end