#1 Create a local variable and modify it at an inner scope. You can try
		#a) re-assigning the variable to something else
			#a = 8
			#2.times do |n|
			#	a = 2
			#end

			#puts a


		#b) call a method that doesn’t mutate the caller

			#b = [1,2,3,4]

			#def mutate(array)
			#	array.uniq
			#end
			#print b
			#mutate (b)
			#print b

		#c) call a method that mutates the caller.
			#c = [5,6,7,8]
			#def really_mutate(array)
			#array.pop
			#end

			#print c
			#really_mutate(c)

			#puts c


#2 Create a local variable at an inner scope and try to reference it in the outer scope. 
#What happens when you have nested do/end blocks?
			# a = 2

			#5.times do |n|
			#	a = 6
			#	b = 3
			#end

			#puts a
			#puts b


