def caesar_cipher(string, num)
    string.each_char.with_index do |letter, index|
        (1..num).each {letter = letter.next} if letter =~ /[a-zA-Z]+/
        letter = letter[1] if letter.length > 1
        string[index] = letter
    end
end

print caesar_cipher("What's your name?", 2)
