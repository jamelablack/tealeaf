#Tips for getting started with the Blackjack game:
#1. Write out your requorements in paragraph form
#2. Extract major nouns -> classes
#3. Extract major verbs  -> instance methods
#4. Group instance methods into classes

# Possible nouns
	# Player
	# Dealer
	# Card
	# Deck

class Card #class that mimics the actual card. Attributes to find the value of a card - value, suit.
	attr_accessor :suit, :value
	def initialize(s,v)
		@suit = s
		@value = v
	end

	def to_s
		"Your card is a #{suit} of #{value}."
	end

end

class Deck #When builing this app procedurally - we had to create a nested arrayusing the product method. Buit instad with OO, 
	#we are iterating over array to form a new one.
	attr_accessor :card

	def initialize()
		@cards = []
		['Hearts', 'Diamonds', 'Clubs', 'Spades'].each do |suit|
			['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'King', 'Queen', 'Ace'].each do |face_value|
				@cards << Card.new(suit, face_value)
			end
		end


		shuffle!

	def shuffle! #we can call the shuffle method because shuffle is an array method and cards in the array class.
		cards.shuffle!
	end

	def deal #the deealer uses the deck to deal
		cards.pop
	end

end


class Player


end

class Dealer


end

class Blackjack
	def initialize #another way to use initialize
		@player = Player.new("Jamela")
		@dealer = Dealer.new("FatsTT")
		@deck = Deck.new
	end

Blackjack.new.run

