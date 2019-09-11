# frozen_string_literal:true

def cipher(string, offset)
  alphabet = ("a".."z").to_a
  offset = offset.to_i
  encrypted_array = []
  string.each_char do |character|
    if character =~ /[^a-zA-Z]/
      encrypted_array << character
      next
    end

    is_upcase = character == character.upcase
    index = alphabet.find_index(character.downcase)
    shifted_character = alphabet[(index + offset) % 26]

    encrypted_array << if is_upcase
                         shifted_character.upcase
                       else
                         shifted_character
                       end
  end
  encrypted_array.join("")
end
