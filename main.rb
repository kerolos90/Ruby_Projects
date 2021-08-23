require_relative 'player_game.rb'
require_relative 'computer_game.rb'


puts "                                                               Welcome to the Mastermind game!"
puts "\nInstructions: This game requires the challenger to select the correct order of the code in a limited number of guesses. If the challenger is unable to guess correctly, they lose!"
puts "As the challenger makes guesses on the code, there will be a useful hints section that will show if any portion of the guess is correct but won't show which one." 
puts "A \u2605 symbol tells you that a number is correct and in the right position. A \u2606 symbol tell you that the number is correct but in the wrong position."
puts "You can also play the computer and create the code for the computer to guess your code!"
puts "\nIf you want to guess the computer's code enter 1. If you want to give the computer a code to guess, enter 2! :"

choice = gets.chomp
while (choice != "1" && choice != "2")
    puts "Not a valid entry, please try again:"
    choice = gets.chomp
end 

if choice == "1"    
    player_game = Game.new(10)
elsif choice == "2"
    puts "Enter the secret code for the computer to guess (A four digit number using numbers 1-6):"
    code = gets.chomp.split("")
    while (code.length != 4 ||code.any? { |i| ["0","7","8","9"].include? i })
        puts "Invalid code entry, try again:"
        code = gets.chomp.split("")
    end
    computer_game = Computer.new(code)
end

