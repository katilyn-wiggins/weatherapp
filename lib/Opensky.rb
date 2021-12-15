require 'httparty'

class Opensky
  include HTTParty
  format :json

  base_uri 'api.openweathermap.org'

  attr_accessor :temp, :location, :icon, :desc, :url, :feel_like

  def initialize(response)
    @temp = response['main']['temp']
    @location = response['name']
    @icon = response['weather'][0]['icon']
    @desc = response['weather'][0]['description']
    @feel_like = response['main']['feels_like']
  end

  def self.get_weather
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=london&appid=a5a5358f226f7238192b306280fba75e")
    if response.success?
      new(response)
    else
      raise response.responses
    end
  end

end
