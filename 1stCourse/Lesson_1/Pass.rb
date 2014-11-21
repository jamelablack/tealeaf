#Pass by reference vs value

#Create a method that takes an array as a parameter. 
#Within that method, try calling methods that do not mutate the caller. 
#How does that affect the array outside of the method? 
#What about when you call a method that mutates the caller within the method?
#Part 1
			#a = [1,2,3,4,5]

			#def pass_by(array)
			#	array.first
			#end

			#puts a

			#pass_by(a)

			#print a

#Part 2
b = [5,6,7,8,9]

def will_mutate(array)
	array.pop
end

puts b

will_mutate(b)

print b

