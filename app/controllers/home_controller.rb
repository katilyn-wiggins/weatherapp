require 'Opensky'

class HomeController < ApplicationController
  def index
  end

  def opensky
    @weather = Opensky.get_weather
  end
end
