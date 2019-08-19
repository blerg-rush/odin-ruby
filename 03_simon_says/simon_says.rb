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

