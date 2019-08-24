def cipher( string, offset )
  alphabet = ("a".."z").to_a
  encrypted_string = ""
  string.each_char do |character|
    if character == " "
      encrypted_string << " "
      next
    end

    upcase = character == character.upcase #Will need to convert back if it is
    index = alphabet.find_index( character.downcase )
    new_character = alphabet[( index + offset ) % 26 ]

    if upcase
      encrypted_string << new_character.upcase
    else
      encrypted_string << new_character
    end
  end
  return encrypted_string
end

puts "This is a test string: " + cipher( "This is a test string", 6 )
puts "Negative numbers: " + cipher( "Negative numbers", -16 )
puts "Easy mode: " + cipher( "Easy Mode", 1 )
puts "Fooled you: " + cipher( "Fooled you", 0 )