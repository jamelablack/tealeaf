Live Session - Metaprogramming
- opening classes
- *send* method
- method missing
- define_method


In programming, we are normally working with data. Metaprogramming manipulates code at runtime. 

Every class in Ruby is wide-open, the class can added to but not overwritten. 
You should never modify the class b/c it will cause problems for all using your code.

You only want to override the ".to_s" method.

arr = [1, 2, 3]

arr.sample


====Send Method
The above is:
Call the sample method on the arr object
Sending a message of .sample to object arr

====Method Missing

Method missing will run when you call a method that has not been defined rather than generating an error after looking up the chain. 
This is a catch all and intercepts all exceptions.
You must define method_missing

class Car
	def method_missing(method_name,*ARGs)
		puts "Hey...you found me!"
	end
end

=======Define Method
Allows us to dynamically on the fly, define a new method.	

So if we wanted to create an instance method we would call a  Car.class_eval (do....end) within the method_missing 
on the class.
To do create a class method, call Instance.class_eval (do...end) on the class - b/c classes are objects of the Class class.

class Car
	def method_missing(method_name, *args)

		#dynamically create instance method
		Car.class_eval do
			define_method(method_name) do #method_name takes a :symbol
				puts "here's the color!"
			end
		end

		send(method_name, *args)#method_name takes a :symbol
	end
end

ford = Car.new
ford.color

======Real world example
User.find_by(:email)



======.inspect 
displays the type of object





