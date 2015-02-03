require 'open_weather'
class Weather
	def initialize(*args)
		@location = args[0] ? args[0] : "Victoria, BC"
		@type = args[1] ? args[1] : "current"
	end

	def get
		if @type == "current"
			OpenWeather::Current.city(@location)
		elsif @type == "forecast"
			OpenWeather::Forecast.city(@location)
		end
	end

end

