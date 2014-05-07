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

  def get_seven_day_forecast(city, state, temperature_type)
    http_response = Faraday.get("#{@base_url}/forecast/daily?q=#{city},#{state}&mode=json&cnt=7")
    parsed_test = parse_text(http_response.body)
    create_forecast_array(parsed_test, temperature_type)
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

  def create_forecast_array(parsed_text, temperature_type)
    forecast_array = []
    parsed_text["list"].each do |weather_info|
      temperature = {}
      temperature["day"] = KelvinConverter.new(weather_info["temp"]["day"]).convert(temperature_type)
      temperature["min"] = KelvinConverter.new(weather_info["temp"]["min"]).convert(temperature_type)
      temperature["max"] = KelvinConverter.new(weather_info["temp"]["max"]).convert(temperature_type)
      temperature["night"] = KelvinConverter.new(weather_info["temp"]["night"]).convert(temperature_type)
      temperature["weather_type"] = weather_info["weather"][0]["main"]
      temperature["weather_description"] = weather_info["weather"][0]["description"]
      forecast_array << temperature
    end
    forecast_array
  end

end