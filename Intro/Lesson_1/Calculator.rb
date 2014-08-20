#Calculator.rb

#string interpolation vs concat
#extract repetitve logic into methods
#keep track of variable class for concatenation or comparison
#you want to avoid converting raw data. Sace user input in its raw format to perserve its data integrity and keep ability to run data analysis on user data later.
#don't spray your program with puts, use pry instead (which allows you to see the state of your application)
#place binding.pry immediately before where you think the problem is in your code or in the method. The best errors are those you can reproduce consistently.
#var scope - Local variables initialized outer scope can be reassigned inner scope but variables initialized
#inner scope cannot be accessed outer scope
require 'pry'

def question(msg)
	puts "------------------ #{msg}------------------"
end

question "What's the first number?"
num1 = gets.chomp

question "What's the second number?"
num2 = gets.chomp

say "1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp

#binding.pry

if operator == '1'
	result = num1.to_i + num2.to_i
elsif operator == '2'
	result = num1.to_i - num2.to_i
elsif operator == '3'
	result = num1.to_i * num2.to_i
else #operater == '4'
	result = num1.to_f / num2.to_f
end

puts "Result is #{result}."