def add ( first_number, second_number)
  return first_number + second_number
end

def subtract ( first_number, second_number )
  return first_number - second_number
end

def sum array
  sum = 0

  array.each do |number|
    sum += number
  end

  return sum
end

def multiply ( first_number, *more_numbers )
  product = first_number

  more_numbers.each do |number|
    product *= number
  end

  return product
end