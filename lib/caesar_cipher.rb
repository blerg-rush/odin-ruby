def cipher( string, offset )
  alphabet = ("a".."z").to_a
  encrypted_string = ""
  string.each_char do |character|
    unless character =~ /[a-zA-Z]/
      encrypted_string << character
      next
    end

    is_upcase = character == character.upcase #Will need to convert back if it is
    index = alphabet.find_index( character.downcase )
    shifted_character = alphabet[( index + offset ) % 26 ]

    if is_upcase
      encrypted_string << shifted_character.upcase
    else
      encrypted_string << shifted_character
    end
  end
  return encrypted_string
end
