# frozen_string_literal: true

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
