class Tree
  attr_reader :root

  def initialize(array = nil)
    @root = build_tree(array)
  end

  def build_tree(array)
    return @root = nil if array.nil?

    sorted_array = array.sort.uniq
    @root = build_branch(sorted_array)
  end

  def insert(value)
    return @root = Node.new(value) if @root.nil?

    @root.insert(value)
  end

  def delete(value)
    return false if @root.nil?

    if value == @root.data
      return @root = @root.right if @root.left.nil?
      return @root = @root.left if @root.right.nil?
    end

    @root = @root.delete(value)
  end

  private

    def build_branch(array)
      return nil if array.size.zero?

      node_index = array.size / 2
      node = Node.new(array[node_index])
      return node if node_index.zero?

      node.left = build_branch(array[0..node_index - 1])
      node.right = build_branch(array[node_index + 1..-1])
      node
    end
end

class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    data <=> other.data
  end

  def insert(value)
    return false if value == @data

    if value < @data
      @left.nil? ? @left = Node.new(value) : @left.insert(value)
    else
      @right.nil? ? @right = Node.new(value) : @right.insert(value)
    end
  end

  def delete(value)
    if value < @data
      @left = @left.delete(value) unless @left.nil?
    elsif value > @data
      @right = @right.delete(value) unless @right.nil?
    else
      return @right if @left.nil?
      return @left if @right.nil?

      @data = @right.inorder_successor
      @right = @right.delete(@data)
    end
    self
  end

  def inorder_successor
    minimum = @data
    node = self
    until node.left.nil?
      minimum = node.left.data
      node = node.left
    end
    minimum
  end

  def depth(node)
    return 0 if node.nil?

    left_depth = depth(node.left)
    right_depth = depth(node.right)

    [left_depth, right_depth].max + 1
  end
end

p empty_tree = Tree.new
p tree = Tree.new([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17])
puts "Deleting 9"
tree.delete(9)
puts "Tree without 9"
p tree
puts "Deleting 10"
tree.delete(10)
puts "Tree without 10"
p tree
puts "Deleting 11"
tree.delete(11)
puts "Tree without 11"
p tree
puts "Deleting 12"
tree.delete(12)
puts "Tree without 12"
p tree
puts "Deleting 13"
tree.delete(13)
puts "Tree without 13"
p tree
puts "Deleting 14"
tree.delete(14)
puts "Tree without 14"
p tree.instance_variables
puts "Root:"
p tree.root
puts "Deleting 15"
tree.delete(15)
puts "Tree without 15"
p tree
puts "Deleting 16"
tree.delete(16)
puts "Tree without 16"
p tree
puts "Deleting 17"
tree.delete(17)
puts "Tree without 17"
p tree
puts "Deleting 17"
tree.delete(17)
puts "Tree without 17"
p tree



