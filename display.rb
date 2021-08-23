require 'colorize'

module Display
    VERTICAL_STRAIGHT_LINE = "\u2551"
    TOP = "\u2554" + "\u2550" * 20 + "\u2557"
    BOTTOM = "\u255A" + "\u2550" * 20 + "\u255D"

    DICTIONARY = {
        1 => '  1  '.white.on_light_cyan,
        2 => '  2  '.magenta.on_light_white,
        3 => '  3  '.blue.on_light_yellow,
        4 => '  4  '.red.on_light_green,
        5 => '  5  '.light_green.on_red,
        6 => '  6  '.black.on_magenta   
    }

    def display_guess(guess)
        guess.each_with_index do |x, y|
            guess[y] = guess[y].to_i
        end
        puts TOP
        print VERTICAL_STRAIGHT_LINE
        print DICTIONARY[guess[0]]
        print DICTIONARY[guess[1]]
        print DICTIONARY[guess[2]]
        print DICTIONARY[guess[3]]
        puts VERTICAL_STRAIGHT_LINE
        puts BOTTOM
    end  

    def check_match(code_array, guess)
        if code_array == guess
            print "Nice job, you cracked the code!"
        else 
            full_star =0
            empty_star=0
            print "Hint: "
            code_array.each_with_index do |x, y|
                if guess.include? code_array[y]
                    guess[y] == code_array[y] ? full_star +=1 : empty_star +=1
                end
            end
            print "\u2605 " * full_star
            print "\u2606 " * empty_star
        end
        puts "\n"
    end
end