# TYPES OF LOOPS:
# 1. Simple Loop (do..end)
# 2. Simple Loop ({})
# 3. Controlling Loop Execution (break/next)
# 4. While
# 5. Until
# 6. Do/While Loop (begin.... end while)
# 7. For Loops
# 8. Conditions within Loops (break, next)
# 9. Interation
# 10. Recursion



## A simple loop
# Option 1
# <loop> do |variable|
# 	code for execution
# end

# Option 2
# {|variable| code for execution}

# * Will only stop in you include keyword: break or hit Ctrl-C

##Controlling Loop execution
# 1. declare variable
# 2. Loop do
# 3. increment variable
# 4. puts "something"
# 5. include if
# 6. break/next
# 7. end
# 8.end
# ____
# Example 1
# i = 0
# loop do 
# 	i += 1
# 	puts "#{i}"
# 	break
# end

# Example 2
# i = 0
# loop do
# 	i += 1
# 	puts "#{i}"
# 	if x == 10
# 		break 
# 	end 
# end

## While Loop - While represents if loops 
# puts "What is x?"
# x = gets.chomp.to_i

# while x >= 0
# 	puts x
# 	x -= 1
# end
# puts "Done!"

##Until Loop - Until represents an unless conditional loop

# puts "What is x?"
# x = gets.chomp.to_i

# until x > 5
# 	puts "Your number is #{x}."
# 	x += 1
# end
# puts "Done!"

## Do/While Loops - designed to only run once while variable fits in the conditional
# for example, x >= 0. Code is run prior to conditional check. 
#Does not require a do/end but rather a begin/end.

# puts "What is x?"
# x = gets.chomp.to_i
# begin
# 	puts  x
# 	x -= 1
# end while x > 0

## For Loops - used to loop over a finite number of elements
#  puts "What is x?"
#  x = gets.chomp.to_i

#  for i in 1..x do 

#  	puts i

# end
#____
#Example 2

# x = [1, 2, 3, 4, 5]
# for i in x do
# 	puts i
# end

# puts "Done"


## Conditionals Within Loops
#Example 1 - using .odd?
# x = 0

# while x <= 10
# 	if x.odd?
# 		puts x 
# 	end
# 	x += 1
# end

#Example 2 - using the reserve words: next.
#Next means it will jump to the next loop interation without executing the code beneath it


# x = 0
# while x <= 10
# 	if x == 3
# 		x += 1
# 		next
# 	elsif x.odd?
# 		puts x
# 	end
# 	x += 1
# end

#Example 3 - using the reserve word: break.
#Break means to exit the loop immediately without execuing anymore code in the loop.


# x = 0
# while x <= 10
# 	if x == 7
# break
# 	elsif x.odd?
# 		puts x
# 	end 
# 	x += 1
# end

## Iterators
# Iterators loop over a given set of data and allow you to operate over each element in the collection
# Iterators use:
# do..end/{}
# .each
# |variable|

# names = ["Jamela", "Jessica", "Sasha", "Amber"]
# x = 1
# # names.each {|name| puts name}
# names.each do |name|
	
# 	end

## Recursion is another method of looping - calling a method from with in itself.

Double a number until the pre-doubled number is greater than 10.



Using Fibonacci Sequence
def fibonacci (number)
	if (number) < 2
		number
	else fibonacci(number - 1) + fibonacci(number -2)
	end
end

puts fibonacci(6)
Write a number that counts down to zero
def down_to_zero(number)
	if number == 0
		puts number
	else down_to_zero(number-1)
	end


