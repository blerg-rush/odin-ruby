def merge_sort(array)
  return array if array.size < 2

  half = array.size / 2
  a = merge_sort(array[0, half])
  b = merge_sort(array[half, array.size - half])
  merge(a, b)
end

def merge(one, two)
  merged_array = []
  until one.empty? && two.empty?
    merged_array << if one.empty? || two.first < one.first
                      two.shift
                    elsif two.empty? || one.first < two.first
                      one.shift
                    else
                      two.shift
                    end
  end
  merged_array
end
