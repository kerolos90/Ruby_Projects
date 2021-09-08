require 'yaml'

class Game

  def initialize
    rand_num = rand(0..61406)
    word = File.open('words.txt') do |f|
      rand_num.times { f.gets } 
      f.gets                 
    end
    @word = word[0..word.length-2]
    
    @guess_remaining = 6

    @guess_array = []
    @word.each_char.with_index  do |letter,index|
      @guess_array[index] = "_"
    end
    @hangman_array = [
      ['   ______'],
      ['  |     |'],
      ['  |     '],
      ['  |    '],
      ['  |    '],
      ['__|__']
    ]

    @wrong_guess = []
  end

  def display_method()
    @hangman_array.each do |line|
      puts line
    end
    puts ""
    @guess_array.each_with_index do |line, index|
      print " #{line}"
    end
    puts ""
  end

  def compare_guess(p_guess)
    if @word.downcase.include?(p_guess.downcase)
      @word.chars.each_with_index do |letter, index|
        @guess_array[index] = letter if letter.downcase == p_guess.downcase
      end  
      puts "Good guess!"
    else
      wrong_guesses_array = [
        ['  |     O'],
        ['  |     |'],
        ['  |    /|'],
        ['  |    /|\\'],
        ['  |    / '],
        ['  |    / \\']
      ]

      @wrong_guess.push(p_guess)
      case @guess_remaining
      when 6
        @hangman_array[2] = wrong_guesses_array[0]
      when 5
        @hangman_array[3] = wrong_guesses_array[1]
      when 4
        @hangman_array[3] = wrong_guesses_array[2]
      when 3
        @hangman_array[3] = wrong_guesses_array[3]
      when 2
        @hangman_array[4] = wrong_guesses_array[4]
      when 1 
        @hangman_array[4] = wrong_guesses_array[5]
        puts "Game over, you lose!"
      end
      @guess_remaining -=1  
    end
  end
 
  def prompt()
    while @guess_remaining > 0 
      puts "Enter a letter guess(#{@guess_remaining} wrong guess(es) remaining):"
      player_guess = gets.chomp
      if player_guess == "save"
        break
      else
        if player_guess.match?(/[A-Za-z]/)
          compare_guess(player_guess)
        else
          puts "INVALID ENTRY, TRY AGAIN!!!"
        end
        display_method()
        puts "Wrong guesses: #{@wrong_guess}"
        if @word.chars == @guess_array
          @guess_remaining = 0
          puts "Good job, you win!"
        end
      end
    end
  end

end
