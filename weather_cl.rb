require_relative 'weather'

puts "Welcome to Weather CL"
puts "What city do you need weather for?"
city = gets.chomp

weather = Weather.new city
puts "You typed #{weather.city}"
