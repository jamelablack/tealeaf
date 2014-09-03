#Blackjack Rules
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
- If the player "hits", then repeat the above, but if the palyers stays, then the player's total value is saved,
  and turned over to the dealer.

In Order to Win:
- The Dealer must hit until she has at least 17.
- If the dealer busts, then the player wins.
- If the dealer hits 21, the dealer wins. 
- If however, the dealer stays, then we compare the sumes of the two hands between the player and dealer;
  higher value wins.=end
=end

=begin
#Pseudo Code:
Must have a deck of cards
Dealer and Player must be able to select two cards repeatively 
Hit or stay
Must find winner when Player or Dealer hand reaches 21
Or must find highest hand when dealer reaches 17 in hand.
=end



#BLACKJACK GAME
#We are developing this program procedurely, meaning that we need to list our code according to when its
#needed in the program.

def calculate_total(cards) #nested array of [['hearts', '3'], ['spades', '4']]
	#We want to create methods for extractable, reusable code
	#But the object must be in the same form
	#you don't have to explicitly indicate "return" when you want to render or puts a value, in ruby, the last line is 
	#returned implicitly.

	arr = cards.map{|e| e[1] }

	total = 0
	arr.each do |value| 
		if value == "A"
			total += 11
		elsif value.to_i == 0 #if card value has no integer value (equals 0), add 10
			total += 10 #in instances of Jack, Queen, or King
		else
			total += value.to_i #if card has an integer value
		end
	end
#correct for Aces
arr.select{|e| e == "A"}.count.times do
	total -= 10 if total > 21	
	end
	total
end


=begin
#replaced by the loop above
if arr.include?("A") && total > 21
	total -= 10

	end

	total

end
=end


#Start Game
puts "Welcome to Jam's Blackjack Table!" "\n" "....dealer shuffles deck...." "\n" "Let's play!"

#variables
suit = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
cards = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'K', 'Q', 'J', 'A']


#best to use the .product method to combine the arrays
#Alternative Approach
=begin
deck = []
suit.each do |suit|
	cards.each do |card|
		deck << [suit, card]
	end
=end

#Shuffle & deal cards
deck = suit.product(cards)
deck.shuffle!

mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

#puts "My hand is :" + mycards.to_s
#puts "Dealer's hand is:" + dealercards.to_s

#Show cards
puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}."
puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of #{mytotal}."
puts ""



#Player turn
if mytotal == 21
	puts "Congratulations, You hit Blackjack! You win!"
	exit
end
#Check to see if Dealer has Blackjack
if dealertotal == 21
	puts "Sorry, Dealer hit Blackjack! You lose"
	exit
end

while mytotal < 21
	puts "What would you like to do?" "\n" "1) hit 2) stay"
	hit_or_stay = gets.chomp	
	
	if !["1", "2"].include?(hit_or_stay)
		puts "Error: You must enter 1 or 2"
		next #go to the next loop in this while loop	
	end

	#stay
	if hit_or_stay == "2"
		puts "You chose to stay"
		break
	end

	#hit
	new_card = deck.pop
	puts "Dealing card to player: #{new_card}"
	mycards << new_card
	mytotal = calculate_total(mycards)
	puts "Your total is now #{mytotal}"

	if mytotal == 21
		puts "Congratulations, You hit Blackjack! You win!"
		exit
	elsif mytotal > 21
		puts "Sorry, it looks like you busted!"
		exit
	end		
end

# Dealer turn
#We can reuse variables like new_card for both dealer and player because they are local variables and variables are confined to 
#to the "end"s
if dealertotal == 21
	puts "Sorry, Dealer hit Blackjack! You lose"
	exit
end

while dealertotal < 17
	new_card = deck.pop
	puts "Dealing new card for dealer: #{new_card}"
	dealercards << new_card
	dealertotal = calculate_total(dealercards)
	puts "Dealer total is now: #{dealertotal}"

	if dealertotal == 21
		puts "Sorry, dealer hit Blackjack, you lose."
		exit
	elsif dealertotal > 21
		puts "Congratulations, dealer busted! You win!"
		exit
	end
end

#Compare hands if Dealer has total of 17, 18, 19, or 20 - to see which is highest

puts "Dealer's cards: "
dealercards.each do |card|
	puts "=> #{card}"
end
puts ""

puts "Your cards: "
mycards.each do |card|
	puts "=> #{card}"
end
puts ""

if dealertotal > mytotal
	puts "Sorry, Dealer wins."
elsif dealer < mytotal
	puts "Congratulation, you win!"
else
	outs "It's  tie!"
end

exit

















