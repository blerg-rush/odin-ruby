require "pry"

class Game
  WORDS = File.open("5desk.txt", "r", &:read).split("\r\n")
end
