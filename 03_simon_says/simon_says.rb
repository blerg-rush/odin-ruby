def echo command
  return command
end

def shout command
  return command.upcase
end

def repeat (command, times=2)
  return ("#{command} " * times).strip
end

