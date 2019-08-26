# frozen_string_literal: true

def bubble_sort(array)
  switched = true
  while switched == true do
    switched = false
    array.each_with_index do |_value, i|
      next if i == array.length - 1

      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        switched = true
      end
    end
  end
  array
end

p bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(array)
  switched = true
  while switched == true
    switched = false
    array.each_with_index do |_value, i|
      next if i == array.length - 1

      if yield(array[i], array[i + 1]).positive?
        array[i], array[i + 1] = array[i + 1], array[i]
        switched = true
      end
    end
  end
  p array
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end