require 'httparty'

class Opensky
  include HTTParty
  format :json

  base_uri 'https://api.openweathermap.org'

  attr_accessor :temp, :location, :desc, :feels_like

  def initialize(response)
    @temp = convert_k_to_f(response['main']['temp'])
    @location = response['name']
    @desc = response['weather'][0]['description']
    @feels_like = convert_k_to_f(response['main']['feels_like'])
  end

  def self.get_weather(city, state)
    response = HTTParty.get("#{base_uri}/data/2.5/weather?q=#{city},#{state}&appid=#{ENV['opensky_key']}")
    if response.success?
      new(response)
    else
      raise response.response
    end
  end

end

private

def convert_k_to_f(kelvin)
  ((kelvin.to_i - 273.15) * (9 / 5) + 32).round
end
