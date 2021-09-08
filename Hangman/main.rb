require_relative 'hangman_game.rb'

puts "Welcome to the hangman game! If you have never played the game before, here are the rules. A word will be chosen by the computer and you will have a chance to guess it."
puts "You will be given a hint on how many characthers the word is and you can guess each letter. You can only guess six (6) wrong times before the game is over!"
puts
puts "Your wrong guesses will be shown to help you keep track of your guesses. Good luck!"
puts "If you would like to save the game at any time, just type save and enter the name of the save file you would like to save your game under. "
puts

def save_game(game)
    puts "Enter your file save name:"
    filename = gets.chomp + ".yaml" 

    if File.exists?(filename)
        puts "A previous save game exists, would you like to overwrite this file? Enter y or n"
        answer = gets.chomp
        while answer != "y" && answer != "n"
            puts "Invalid entry, please try again:"
            answer = gets.chomp
        end
        if answer == "y"
            File.open(filename, 'w'){ |f| f.write game.to_yaml}
            puts "Game saved."
        elsif answer == "n"
            save_game(game)
        end
    else
        File.open(filename, 'w'){ |f| f.write game.to_yaml}
        puts "Game saved."
    end
  end

puts "Enter 1 if you would like to start a new game or enter 2 if you would like to load a saved game:"
choice = gets.chomp

while choice != "1" && choice != "2"
    puts "Invalid entry, please try again:"
    choice = gets.chomp
end

if choice == "1"
    game = Game.new()
    game.display_method
    game.prompt
    save_game(game)
elsif choice == "2"
    puts "Enter the name of your file:"
    filename = gets.chomp + ".yaml"
    
    if File.exists?(filename)
        open_game = YAML.load(File.read(filename))
        open_game.display_method
        open_game.prompt
        save_game(open_game)
    else
        puts "File doesn't exist..exiting game."
    end
end
