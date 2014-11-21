	#Rock, Paper, Scissors Program
	#Write Pseudo code - what are we trying to accomplish in code.
	#1 All players pick paper, rock or scissors
	#2 compare: rock > scissor, scissor > paper, paper > rock, or tie if same
	#3 play again (loop do)

	#Blocks create scope for our local variables. Not all do/end indicates a block. One guildeline, if the do/end is immediately behind 
	#a method call. Loop do/end variables are blocks.


	CHOICES = {'p'=> 'Paper', 'r' =>'Rock', 's'=> 'scissors'}

	p "Welcome! Let's Play Rock, Paper, Scissors"


	def display_winning_message(winning_choice)
		case winning_choice
		when 'p'
			puts "Paper covers rock!"
		when 'r'
			puts "Rocks smashes scissors!"
		when 's'
			puts "Scissors cuts paper!"
		end
	end

	loop do
		#player makes a pick
		begin
		p "Choose one: (r/p/s):"
		player_choice = gets.chomp.downcase
		end until CHOICES.keys.include?(player_choice) #check to see if player's response is one of the hash keys from CHOICES
		p "Great answer!"

		#computer chooses
		computer_choice = CHOICES.keys.sample

		#possible outcomes

		#It's a tie!
		if player_choice == computer_choice
			puts "You got lucky! It's a tie!"

		# Player wins!
		elsif (player_choice == 'r' && computer_choice == 's') || (player_choice == 's' && computer_choice == 'p')
		(player_choice == 'p' && computer_choice == 'r')
		
			#puts "You chose #{player_choice} and Computer chose #{computer_choice}!"
			display_winning_message(player_choice)
			puts "Congrats, You Won!"
			
		# Computer Won!
		else
					#puts "You chose #{player_choice} but Computer chose #{computer_choice}!"
			display_winning_message(computer_choice)
			puts "Computer Won :("
		end


		puts "Play again? (y/n)"
		break if gets.chomp.downcase != 'y'

	end

	puts "Goodbye!"
