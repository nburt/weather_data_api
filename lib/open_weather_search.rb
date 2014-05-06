require 'faraday'
require 'json'
require './lib/kelvin_converter'

class OpenWeatherSearch

  attr_reader :base_url

  def initialize(base_url)
    @base_url = base_url
  end

  def get_temperature(city, state, temperature_type)
    if temperature_type == 'F'
      http_response = Faraday.get("#{@base_url}/find?q=#{city},#{state}&mode=json")
      parsed_text = JSON.parse(http_response.body)
      temperature = {}
      parsed_text["list"].each do |weather_info|
        temperature["temp"] = KelvinConverter.new(weather_info["main"]["temp"]).fahrenheit
        temperature["temp_min"] = KelvinConverter.new(weather_info["main"]["temp_min"]).fahrenheit
        temperature["temp_max"] = KelvinConverter.new(weather_info["main"]["temp_max"]).fahrenheit
      end
      temperature
    end
  end

end