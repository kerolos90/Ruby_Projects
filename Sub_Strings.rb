def substrings(string, dictionary)
    result = {}
    string_array = string.split(' ')
    dictionary.each do |word|
        string_array.each do |string_word|
            if string_word.downcase.include?(word.downcase)
                result.has_key?(word) ? result[word] += 1 : result[word] = 1
            end
        end
    end
    result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
