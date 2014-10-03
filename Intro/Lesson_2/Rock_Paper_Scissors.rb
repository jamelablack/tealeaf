# Pseudo code:
# Nouns:
# Player
# Computer
# RPSGame

# Verbs:
# pick


# 1. Player picks R/P/S
# 2. Computer pick R/P/S
# 3. Then determine winner basee on choice


class Player < RPSGame
	attr_accessor :name

	def initialize(n)
		@name = n

	end



end



class Computer <RPSGame
	def initialize(n)
		@name = n
	end

end


class RPSGame
	def initialize
		Player.new("Jam")
		Computer.new("RbyWoo")
		puts "Let's play Rock, Paper, Scissors!"
	end

	def pick
		

	end

	def play_again?
		puts "Would you like to play again - y or n?"
		answer = gets.chomp
		if answer == 'y'
			RPSGame.new
		else
			"Thanks for playing... come again!"
		end
	end
end
