require_relative 'display.rb'

class Computer
    include Display
    def initialize(player_code)
        @player_code = player_code
        @player_code.each_with_index do |x, y|
            @player_code[y] = @player_code[y].to_i
        end
        @computer_guess_count =10
        @computer_guess = (1...7).to_a.shuffle.first(4)
        computer_choices
    end

    def computer_choices
        while(@computer_guess_count > 0)
            display_guess(@computer_guess)
            check_match(@player_code,@computer_guess)
            @computer_guess_count -=1
            @computer_guess.each_with_index do |x,y|
                if @computer_guess[y] != @player_code[y]
                    @computer_guess[y] = rand(1..6)
                end
            end
            if @computer_guess == @player_code
                display_guess(@computer_guess)
                puts "I guessed it right in #{(10 - @computer_guess_count)} guesses!"
                @computer_guess_count = 0
            end
            sleep(1)
        end
        if @computer_guess != @player_code  
            puts "I lose :(. You win!" 
        end
    end
end