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
    new_node = Node.new(value)
    @root = new_node if @root.nil?

    insert_at(new_node, @root)
  end

  def delete(value)
    return false if @root.nil?
    return @root = nil if @root.data == value

    delete_at(value, @root).nil?
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

    def insert_at(new_node, parent)
      return false if new_node == parent

      if new_node < parent
        return parent.left = new_node if parent.left.nil?

        insert_at(new_node, parent.left)
      else
        return parent.right = new_node if parent.right.nil?

        insert_at(new_node, parent.right)
      end
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
end

p empty_tree = Tree.new
p tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p tree.delete(100)
p tree.insert(100)
p tree.delete(100)

