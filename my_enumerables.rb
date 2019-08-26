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
end
