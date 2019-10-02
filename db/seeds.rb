Airport.delete_all

Airport.create(code: 'YEG')

Airport.create(code: 'YYC')

10.times do
  code = (0..2).map{ ('A'..'Z').to_a[rand(26)] }.join
  Airport.create(code: code)
end