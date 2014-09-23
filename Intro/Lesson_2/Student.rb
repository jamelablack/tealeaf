
class Student
	def initialize(name, grade)
		self.name = name
		@grade = grade
	end

	def grade_better_than?(other_student)
		grade > other_student.grade
	end

	protected
	def grade
		@grade
	end

end


jamela = Student.new("Jamela", 100)
bob = Student.new("Bob", 20)

puts "Well done!" if jamela.grade_better_than?(bob)