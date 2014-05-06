require 'spec_helper'
require './lib/open_weather_search'

describe OpenWeatherSearch do

  it 'will display weather data in fahrenheit' do
    VCR.use_cassette('denver_weather') do
      open_weather_client = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
      temperature_data = open_weather_client.get_temperature('Denver', 'CO', 'F')

      expected_data = {
        "temp" => 72.37,
        "temp_min" => 72.37,
        "temp_max" => 72.37
      }

      expect(temperature_data).to eq expected_data
    end
  end
end