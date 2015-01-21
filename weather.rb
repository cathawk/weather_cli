class Weather
	
	attr_accessor :city

	def initialize city = nil
		@city = city ? city : "Victoria, BC"
	end

end

