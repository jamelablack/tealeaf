# Rules
# Rock, Paper Scissors is game between 2 players where both player's pick a hand of either Rock, Paper, or Scissors. 
# Once selection is made, choices are compared and it's either a tie (if the hands are the same) or r > s, s > p, p > r. 

# Nouns
# Game
# Player < Human
# Player < Computer
# Hand

require "pry"

class Hand
	include Comparable
	
	attr_reader :value

	def initialize(v)
		@value = v
	end

	def <=>(another_hand)
		binding.pry
		if @value == another_hand.value
			0
		elsif (@value == 'p' && another_hand.value == 'r') || (@value == 'r' && another_hand.value == 's') ||
			(@value == 's' && another_hand.value == 'p')

			1
		else

			-1
		end
			
	end

	def display_winning_message
		case @value
		when 'p'
			puts "Paper covers rock!"
		when 'r'
			puts "Rocks smashes scissors!"
		when 's'
			puts "Scissors cuts paper!"
		end
	end
	
end


class Player

	attr_accessor :hand
	attr_reader :name

	def initialize(n)
		@name = n
	end

	def to_s
		"#{name} currently has a choice of #{self.hand.value}."
	end
end

class Human < Player
	def pick_hand
		begin
			puts "Pick one: (p, r, s):"
			c = gets.chomp.downcase
		end until Game::CHOICES.keys.include?(c)
		
		self.hand  = Hand.new(c) #we don't want self.choice to be defined directly in both player and computer
	end
end

class Computer < Player

	def pick_hand
		self.hand = Hand.new(Game::CHOICES.keys.sample)
	end

end





class Game
	CHOICES = {'p'=> 'Paper', 'r' =>'Rock', 's'=> 'scissors'}
	attr_reader :player, :computer

	def initialize
		@player = Human.new("Bob")
		@computer = Computer.new("R2D2")

	end

	def compare_hands 
		if player.hand == computer.hand
			puts "It's a tie!"
		elsif player.hand > computer.hand
			player.hand.display_winning_message
			puts "#{player.name} won!"
		else #player.hand < computer.hand
			computer.hand.display_winning_message
			puts "#{computer.name} won!"
		end

	end


	def play
		player.pick_hand
		computer.pick_hand
		puts player
		puts computer
		compare_hands
	end

end
game = Game.new.play
