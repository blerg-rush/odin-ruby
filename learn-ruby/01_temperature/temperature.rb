def ftoc fahrenheit
  celsius = ( fahrenheit - 32.0 ) * ( 5.0 / 9.0 )
  return celsius
end

def ctof celsius
  fahrenheit = celsius * ( 9.0 / 5.0 ) + 32
  return fahrenheit
end