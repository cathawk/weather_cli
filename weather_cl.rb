require_relative 'weather'
require 'socket'
require 'optparse' 
require 'ostruct'

class WeatherCL
	def initialize
		begin 
			TCPSocket.new( 'google.com', 80 )
		rescue SocketError 
			STDERR.puts "Internet connection not detected.  You must be connected to "
									+ "the internet to get weather information."
			exit 
		end 
		build_options
		print_weather Weather.new(@options.location, @options.forecast_type).get
	end

	private

		def build_options
			@options = OpenStruct.new
			@options.location = "Victoria, BC"
			@options.forecast_type = "current"

			opt_parser = OptionParser.new do |opts|
				
				opts.banner = "WeatherCL is a tool to lookup current weather " \
											+ "and/or weather forecasts.\nUsage:"
											
				opts.on( 	'--location [LOCATION]', 
									'Lookup weather for location, ex - New York, NY' ) do |location|     
					@options.location = location   
				end 

				opts.on( '--type [TYPE]', [ 'current', 'forecast' ],
              "Select type of forecast (current, forecast)") do |t|
        	@options.forecast_type = t
      	end

				opts.on("--help", "Prints this help") do
	        puts opts
	        exit
      	end	
			end
			begin
				opt_parser.parse!(ARGV)
			rescue
				puts opt_parser
				exit
			end
			@options
		end

		def print_weather weather
			if weather['cod'].to_i != 200
				puts "There was an error getting weather"
				exit
			else
				if @options.forecast_type == 'current'
					puts "\n\nCurrent weather for #{@options.location}\n\n"
					puts "Condition: #{weather['weather'][0]['description'].
											split(' ').map{|c| c.capitalize}.join(' ')}"
					puts "Temperature: #{(weather['main']['temp'].to_i.round(1))} \u00B0C"
					puts "Pressure: #{(weather['main']['pressure'].to_i / 1000.0)} kPa"
					puts "Wind: #{weather['wind']['speed']} km/h"
					# Tomorrow print direction of wind
					puts "\n\n"
				elsif @options.forecast_type == 'forcast'
				end	
			end 
		end
end

WeatherCL.new()
