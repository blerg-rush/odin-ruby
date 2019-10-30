require 'csv'
puts 'EventManager Initialized!'

contents = CSV.open 'event_attendees.csv', headers: true,
                                           header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode = row[:zipcode]

  zipcode = '00000' if zipcode.nil?
  zipcode = zipcode[0..4] if zipcode.length > 5
  zipcode = zipcode.rjust(5, '0') if zipcode.length < 5
  
  puts "#{name} #{zipcode}"
end
