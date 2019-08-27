# frozen_string_literal: true

# Extends the existing module with alternative methods
module Enumerable
  def my_each
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    new_array = []
    my_each do |value|
      new_array << value if yield(value)
    end
    new_array
  end

  def my_all?
    new_array = []
    my_each do |value|
      new_array << value if yield(value)
    end
    self == new_array
  end

  def my_any?
    new_array = []
    my_each do |value|
      new_array << value if yield(value)
    end
    !new_array.empty?
  end

  def my_none?
    !my_any?
  end

  def my_count
    number = 0
    my_each do |value|
      if block_given?
        number += 1 if yield(value)
      else
        number += 1
      end
    end
    number
  end

  def my_map
    new_array = []
    my_each do |value|
      new_array << yield(value)
    end
    new_array
  end

  # This is ugly. Fix it later.
  def my_inject(initial = nil)
    number = 0
    my_each_with_index do |value, i|
      number = if i.zero?
                 initial.nil? ? value : yield(initial, value)
               else
                 yield(number, value)
               end
    end
    number
  end
end
