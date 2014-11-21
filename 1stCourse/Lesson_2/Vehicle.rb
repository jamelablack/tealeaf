class Vehicle
	@@number_of_vehicles = 0
	attr_accessor :color
	attr_accessor :year
	attr_accessor :model


	def age
		"Your #{self.model} is #{years_old} years old."
	end

	private

		def years_old
			Time.now.year - self.year.to_i
		end
	

	module Cruisable
		def cruise
			puts "You hit cruise control! You're cruising now!"
		end
	end

	def self.gas_mileage(gallons, miles)
		puts "#{miles / gallons} miles per gallons of gas."
	end

	def initialize(year, color, model)
		@year = year
		@color = color
		@model = model
		@current_speed = 0
		@@number_of_vehicles += 1
	end

	def speed_up(number)
		@current_speed += number
		puts "You just accelerated  #{number} mph and you're going #{@current_speed} mph."

	end

	def current_speed
		puts "Your current speed is #{@current_speed} mph."

	end

	def brake(number)
		@current_speed -= number
		puts "You just decelerated by #{number} mph and you're now going #{@current_speed} mph."

	end

	def shut_off
		@current_speed = 0
		puts "You've just shut off your car, please don't forget your belongings."

	end

	def self.total_number_of_vehicles
		puts "There are #{@@number_of_vehicles} vehicles total."
	end

end

class MyCar < Vehicle
	NUMBER_OF_DOORS = 4
	
	include Cruisable
	
	def to_s
	puts "The car is a #{self.year}, color is #{self.color}, and my model is #{self.model}."
	end
end

class MyTruck < Vehicle
	NUMBER_OF_DOORS = 2
	def to_s
	puts "The truck is #{self.year}, color is #{self.color}, and my model is #{self.model}."
	end
end

car = MyCar.new('2014', 'Red', 'Tesla')
truck = MyTruck.new('2000', 'Blue', 'Ford')

#puts car
#puts truck
#puts Vehicle.total_number_of_vehicles
#puts car.cruise

#puts Vehicle.ancestors
#puts "-----"
#puts MyCar.ancestors
#puts "-----"
#puts MyTruck.ancestors

puts car.age
