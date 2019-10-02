Airport.delete_all
Flight.delete_all

Airport.create(code: 'YEG')

Airport.create(code: 'YYC')

10.times do
  code = (0..2).map{ ('A'..'Z').to_a[rand(26)] }.join
  Airport.create(code: code)
end

Airport.first.departing_flights.build(to_id: Airport.second.id).save

Airport.second.departing_flights.build(to_id: Airport.first.id).save

10.times do
  airports = Airport.all
  from = airports.shuffle.pop
  to = airports.shuffle.pop
  from.departing_flights.build(to_id: to.id).save
end