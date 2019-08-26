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
end
