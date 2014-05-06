require 'faraday'
require 'json'

class OpenWeatherSearch

  attr_reader :base_url

  def initialize(base_url)
    @base_url = base_url
  end

  def get_temperature(city, state)
    http_response = Faraday.get("#{@base_url}/find?q=#{city},#{state}&mode=json")
    parsed_text = JSON.parse(http_response.body)
    temperature = {}
    parsed_text["list"].each do |weather_info|
      temperature["temp"] = weather_info["main"]["temp"]
      temperature["temp_min"] = weather_info["main"]["temp_min"]
      temperature["temp_max"] = weather_info["main"]["temp_max"]
    end
    temperature
  end

end