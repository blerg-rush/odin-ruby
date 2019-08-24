def cipher( string, offset )
  alphabet = ("a".."z").to_a
  encrypted_string = ""
  string.each_char do |character|
    if character == " "
      encrypted_string << " "
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

puts "This is a test string: " + cipher( "This is a test string", 6 )
puts "Negative numbers: " + cipher( "Negative numbers", -16 )
puts "Easy mode: " + cipher( "Easy Mode", 1 )
puts "Fooled you: " + cipher( "Fooled you", 0 )