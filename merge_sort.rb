def merge_sort(array)

end

def merge(one, two)
  merged_array = []
  until one.empty? && two.empty?
    if one.empty?
      merged_array << two.shift
    elsif two.empty?
      merged_array << one.shift
    elsif one.first < two.first
      merged_array << one.shift
    else
      merge_array << two.shift
    end
  end
  merged_array
end
