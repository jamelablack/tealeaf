#Object Oriented Blackjack Game

#1) Abrstaction - the interaction of objects (keeping track of state and behaviors
#2) Encapsulation - encapsulates certain behaviors

# Step 1  - Look at the Requirements
# Step 2 - Pick nouns 
# Step 3 - Think off all actions you want the object to perform and write down method calls (i.e. player.deal) as though the methods already exists.
# Step 4 - Do this for each class.
# Class relationships
#is a => inheritance
# Animal < Dog

#has a relationship => composition (mixin module)
# Player has a hand

class Card
  attr_accessor :suit, :face_value

  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end

  def pretty_output
    "The #{face_value} of #{find_suit}"
  end

  def to_s
    pretty_output
  end

  def find_suit
    ret_val = case suit
                when 'H' then 'Hearts'
                when 'D' then 'Diamonds'
                when 'S' then 'Spades'
                when 'C' then 'Clubs'
              end
    ret_val
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['H', 'D', 'S', 'C'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

  def size
    cards.size
  end
end

module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do|card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
  end

  def total
    face_values = cards.map{|card| card.face_value }

    total = 0
    face_values.each do |val|
      if val == "A"
        total += 11
      else
        total += (val.to_i == 0 ? 10 : val.to_i)
      end
    end

    #correct for Aces
    face_values.select{|val| val == "A"}.count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > 21
  end
end

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(n)
    @name = n
    @cards = []
  end
  def show_flop
  	show_hand
  end
end

class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_flop
  	puts "------ Dealer's Hand ------"
  	puts "=> The first card is hidden"
  	puts "=> Second card is #{cards[1]}"
  end

end

class Blackjack
	attr_accessor :deck, :player, :dealer
	
	def initialize
		@player = Player.new("Jam")
		@dealer = Dealer.new
		@deck = Deck.new
	end

	def start	#write out procedurally what will happen in the game
		set_player_name
		deal_cards
		show_flop

	end

	def set_player_name
		puts "What's your name?"
		player.name = gets.chomp
	end

	def deal_cards
		player.add_card(deck.deal_one)
		dealer.add_card(deck.deal_one)
		player.add_card(deck.deal_one)
		dealer.add_card(deck.deal_one)
	end

	def show_flop
		player.show_flop
		dealer.show_flop
	end
	


end


game = Blackjack.new
game.start


