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
		lookup_weather
		#print_weather
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

		def lookup_weather
			puts @options
			puts Weather.new(@options.location, @options.forecast_type).get
		end
end

WeatherCL.new()
