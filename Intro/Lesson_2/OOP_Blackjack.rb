#Tips for getting started with the Blackjack game:
#1. Write out your requirrements in paragraph form
#2. Extract major nouns -> classes
#3. Extract major verbs  -> instance methods
#4. Group instance methods into classes
=begin
=begin
General:
- Goal: The sum value of your cards must equal 21 (blackjack)
- Both Player and Dealer (Computer) are dealt two cards to start the game.
- All face cards are worth whatever numerical value they show.
- Suits are worth 10. Aces are worth 1 or 11 (whichever is more favorable)

How to Play:
- After being dealt the initial 2 cards, the player goes first and can choose to either "hit" or "stay"
- Hitting means dealing another card. 
- If the player's card sum up to be greater than 21, the Player has "busted" and lost.
- If the sum is 21, the Player wins. 
- If the sum is less than 21, the player can choose to "hit" or "stay" again.
- If the player "hits", then repeat the above, but if the players stays, then the player's total value is saved,
  and turned over to the dealer.

In Order to Win:
- The Dealer must hit until she has at least 17.
- If the dealer busts, then the player wins.
- If the dealer hits 21, the dealer wins. 
- If however, the dealer stays, then we compare the sumes of the two hands between the player and dealer;
  higher value wins.=end
=end

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

