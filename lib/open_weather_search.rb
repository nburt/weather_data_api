require 'faraday'
require 'json'
require './lib/kelvin_converter'

class OpenWeatherSearch

  attr_reader :base_url

  def initialize(base_url)
    @base_url = base_url
  end

  def get_temperature(city, state, temperature_type)
    http_response = Faraday.get("#{@base_url}/find?q=#{city},#{state}&mode=json")
    parsed_text = parse_text(http_response.body)
    create_temperature_hash(parsed_text, temperature_type)
  end

  private

  def parse_text(text)
    JSON.parse(text)
  end

  def create_temperature_hash(parsed_text, temperature_type)
    temperature = {}
    parsed_text["list"].each do |weather_info|
      temperature["temp"] = KelvinConverter.new(weather_info["main"]["temp"]).convert(temperature_type)
      temperature["temp_min"] = KelvinConverter.new(weather_info["main"]["temp_min"]).convert(temperature_type)
      temperature["temp_max"] = KelvinConverter.new(weather_info["main"]["temp_max"]).convert(temperature_type)
    end
    temperature
  end
  
end