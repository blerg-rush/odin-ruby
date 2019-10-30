require 'csv'

def clean_zip(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

puts 'EventManager Initialized!'

contents = CSV.open 'event_attendees.csv', headers: true,
                                           header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode = row[:zipcode]

  puts "#{name} #{clean_zip(zipcode)}"
end
