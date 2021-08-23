require_relative 'display.rb'

class Game 
    include Display
    def initialize(num_of_guesses)
        @num_of_guesses = num_of_guesses
        @code_array = (1...7).to_a.shuffle.first(4)
        prompt
    end

    def prompt 
        while (@num_of_guesses > 0)
            puts "Enter a guess using only numners 1-6 (Remaining guesses #{@num_of_guesses}):"
            @guess = gets.chomp.split("")
            if @guess.length == 4 && !(@guess.any? { |i| ["0","7","8","9"].include? i })
                display_guess(@guess)
                check_match(@code_array, @guess)
                @code_array == @guess ? @num_of_guesses = 0 : @num_of_guesses -=1
            else
                puts "Please enter a four digit number between 1-6."
            end
        end
        if @code_array != @guess
            puts "Game over, you lose!"
            puts "The correct code was:"
            display_guess(@code_array)
        end
    end        
end