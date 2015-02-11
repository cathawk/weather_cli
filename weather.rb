require 'open_weather'
class Weather
	attr_reader :location, :type
	def initialize(*args)
		@location = args[0] ? args[0] : "Victoria, BC"
		@type = args[1] ? args[1] : "current"
	end

	def get
		case @type
		when "current"
			OpenWeather::Current.city(@location, units: 'metric')
		when "forecast"
			OpenWeather::Forecast.city(@location, units: 'metric')
		end
	end

end

