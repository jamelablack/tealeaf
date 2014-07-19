def has_a_b?(string)
	if string =~ /b/
		puts "We have a match"
	else
		puts "We don't have a match"
	end
end

has_a_b? ("baby")
has_a_b? ("mops")
has_a_b? ("Black")
has_a_b? ("Jasmine")