require 'pry'

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

    if @root.data == value
      @root = @root.replace(@root)
    else
      @root.delete(value)
    end
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

    def delete_at(value, parent)
      if value < parent.data
        return false if parent.left.nil?
        return parent.left = nil if parent.left.data == value

        delete_at(value, parent.left)
      else
        return false if parent.right.nil?
        return parent.right = nil if parent.right.data == value

        delete_at(value, parent.right)
      end
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
    return false if @left.nil? && @right.nil?

    if value < @data
      return @left = replace(@left, self) if value == @left.data

      @left.nil? ? false : @left.delete(value)
    else
      return @right = replace(@right, self) if value == @right.data

      @right.nil? ? false : @right.delete(value)
    end
  end

  # Returns the node that will take its reference
  def replace(node, parent = nil)
    return nil if node.left.nil? && node.right.nil?
    return node.left if node.right.nil?
    return node.right if node.left.nil?

    replacement = inorder_successor(node)
    parent.left = replacement unless parent.nil?
    # Something's wrong with this
    replacement.left = node.left unless node.left == replacement
    replacement.right = node.right unless node.right == replacement

    replacement
  end

  def inorder_successor(node)
    successor = node.right
    until successor.left.nil?
      parent = successor
      successor = successor.left
    end
    parent.left = nil unless parent.nil?
    successor
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
puts "Deleting 14"
tree.delete(14)
puts "Tree without 14"
p tree
puts "Deleting 13"
tree.delete(13)
puts "Tree without 13"
p tree
puts "Deleting 11"
tree.delete(11)
puts "Tree without 11"
p tree



