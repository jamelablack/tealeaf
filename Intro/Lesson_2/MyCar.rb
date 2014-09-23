class MyCar
	attr_accessor :year :make :model

	def self.gas_mileage(gallons, miles)
		puts "#{miles / gallons} miles per gallons of gas."

	def initialize(year, color, model)
		@year = year
		@color = color
		@model = model
		@current_speed = 0
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

	def to_s
		puts "My year is #{self.year}, color is #{self.color}, and my model is #{self.model} ."

end


tesla = MyCar.new('2014', 'red', 'T90')

=begin
tesla.speed_up(80)
tesla.speed_up(20)
tesla.current_speed
tesla.brake(40)
tesla.current_speed
tesla.shut_off
tesla.current_speed=end
=begin
=end
MyCar.gas_milage(15,150)




