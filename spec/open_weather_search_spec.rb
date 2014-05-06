require 'spec_helper'
require './lib/open_weather_search'

describe OpenWeatherSearch do

  it 'will display weather data' do
    VCR.use_cassette('denver_weather') do
      open_weather_client = OpenWeatherSearch.new('http://api.openweathermap.org/data/2.5')
      temperature_data = open_weather_client.get_temperature("Denver", "CO")

      expected_data = {
        "temp" => 295.576,
        "temp_min" => 295.576,
        "temp_max" => 295.576
      }

      expect(temperature_data).to eq expected_data
    end
  end
end