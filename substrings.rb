# frozen_string_literal: true

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

def substrings(string, dictionary)
  # initialize the counters object with default value 0
  substring_counts = Hash.new(0)

  # take each word in the string...
  string.split(" ").each do |word|
    # ...against each entry in the dictionary
    dictionary.each do |entry|
      # ...and add to the count if the word contains an entry
      substring_counts[entry] += 1 if word[entry]
    end
  end
  # return the contents of the counters object
  substring_counts
end

p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)