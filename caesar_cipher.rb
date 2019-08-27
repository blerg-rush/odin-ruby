# frozen_string_literal: true

def cipher(string, offset)
  alphabet = ("a".."z").to_a
  encrypted_string = ""
  string.each_char do |character|
    if character =~ /\W/
      encrypted_string << character
      next
    end

    is_upcase = character == character.upcase
    index = alphabet.find_index(character.downcase)
    shifted_character = alphabet[(index + offset) % 26]

    encrypted_string << if is_upcase
                          shifted_character.upcase
                        else
                          shifted_character
                        end
  end
  encrypted_string
end
