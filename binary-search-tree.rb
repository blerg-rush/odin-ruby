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
    current_node = @root
  end

  private

    def build_branch(array)
      return nil if array.size.zero?

      node_index = array.size / 2
      node = Node.new(array[node_index])
      return node if node_index.zero?

      node.left_child = build_branch(array[0..node_index - 1])
      node.right_child = build_branch(array[node_index + 1..-1])
      node
    end

    def insert_at(new_node, parent)
      return false if new_node == parent

      if new_node < parent
        return parent.left_child = new_node if parent.left_child.nil?

        insert_at(new_node, parent.left_child)
      else
        return parent.right_child = new_node if parent.right_child.nil?

        insert_at(new_node, parent.right_child)
      end
    end
end

class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def initialize(data = nil)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def <=>(other)
    data <=> other.data
  end
end

p empty_tree = Tree.new
p tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
