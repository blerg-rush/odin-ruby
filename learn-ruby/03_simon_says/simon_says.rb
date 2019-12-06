def echo command
  return command
end

def shout command
  return command.upcase
end

def repeat ( command, times=2 )
  return ( "#{command} " * times ).strip
end

def start_of_word ( command, how_many=1 )
  index = how_many - 1
  return command[0..index]
end

def first_word command
  array = command.split( " " )
  return array[0]
end

def titleize command
  little_words = ["the", "and", "of", "and", "as", "at", "but", "by", "for", "from", "if", "in", "into", "on", "over", "or", "so", "than", "to", "with"]
  array = command.split( " " )
  capped = []

  capped << array.shift.capitalize

  array.each do |word|
    unless little_words.include?( word )
      capped << word.capitalize
    else
      capped << word
    end
  end

  return capped.join( " " )
end

