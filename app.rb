require 'sinatra/base'
require './lib/open_weather_search'

class App < Sinatra::Application

  get '/' do
    erb :index
  end

  get '/weather' do
    if params[:forecast_type] == "current"
      open_weather_search = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
      temp_hash = open_weather_search.get_temperature(params[:city], params[:state], params[:temperature_type])
      erb :weather, :locals => {:temp_hash => temp_hash, :city => params[:city], :state => params[:state], :temperature_type => params[:temperature_type], :forecast_type => params[:forecast_type]}
    elsif params[:forecast_type] == "seven_day"
      open_weather_search = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
      temp_hash = open_weather_search.get_seven_day_forecast(params[:city], params[:state], params[:temperature_type])
      erb :weather, :locals => {:temp_hash => temp_hash, :city => params[:city], :state => params[:state], :temperature_type => params[:temperature_type], :forecast_type => params[:forecast_type]}
    end
  end

end