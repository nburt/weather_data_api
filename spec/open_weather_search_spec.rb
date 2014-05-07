require 'spec_helper'
require './lib/open_weather_search'

describe OpenWeatherSearch do

  it 'will display weather data in kelvin' do
    VCR.use_cassette('denver_weather') do
      open_weather_client = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
      temperature_data = open_weather_client.get_temperature('Denver', 'CO', 'Kelvin')

      expected_data = {
        "temp" => 295.58,
        "temp_min" => 295.58,
        "temp_max" => 295.58
      }

      expect(temperature_data).to eq expected_data
    end
  end

  it 'will display weather data in fahrenheit' do
    VCR.use_cassette('denver_weather') do
      open_weather_client = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
      temperature_data = open_weather_client.get_temperature('Denver', 'CO', 'Fahrenheit')

      expected_data = {
        "temp" => 72.37,
        "temp_min" => 72.37,
        "temp_max" => 72.37
      }

      expect(temperature_data).to eq expected_data
    end
  end

  it 'will display weather data in celsius' do
    VCR.use_cassette('denver_weather') do
      open_weather_client = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
      temperature_data = open_weather_client.get_temperature('Denver', 'CO', 'Celsius')

      expected_data = {
        "temp" => 22.43,
        "temp_min" => 22.43,
        "temp_max" => 22.43
      }

      expect(temperature_data).to eq expected_data
    end
  end

  it 'will display a weeks worth of data' do
    VCR.use_cassette('denver_weather_7_day_forcast') do
      open_weather_client = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
      temperature_data = open_weather_client.get_seven_day_forecast('Denver', 'CO', 'Kelvin')

      expected_data = [
        {
          "day" => 287.44,
          "min" => 276.46,
          "max" => 287.44,
          "night" => 276.46,
          "weather_type" => "Rain",
          "weather_description" => "light rain",
        },
        {
          "day" => 282.23,
          "min" => 274.82,
          "max" => 282.23,
          "night" => 276.73,
          "weather_type" => "Rain",
          "weather_description" => "moderate rain",
        },
        {
          "day" => 287.21,
          "min" => 271.53,
          "max" => 288.23,
          "night" => 279.79,
          "weather_type" => "Rain",
          "weather_description" => "light rain",
        },
        {
          "day" => 285.93,
          "min" => 276.31,
          "max" => 287.78,
          "night" => 276.31,
          "weather_type" => "Clear",
          "weather_description" => "sky is clear",
        },
        {
          "day" => 285.66,
          "min" => 276.26,
          "max" => 287.18,
          "night" => 277.02,
          "weather_type" => "Rain",
          "weather_description" => "moderate rain",
        },
        {
          "day" => 287.56,
          "min" => 273.78,
          "max" => 287.83,
          "night" => 278.38,
          "weather_type" => "Rain",
          "weather_description" => "light rain",
        },
        {
          "day" => 285.66,
          "min" => 274.06,
          "max" => 288.93,
          "night" => 278.29,
          "weather_type" => "Rain",
          "weather_description" => "light rain"
        }
      ]

      expect(temperature_data).to eq expected_data
    end
  end
end