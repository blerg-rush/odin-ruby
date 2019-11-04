class Tree
  attr_reader :root

  def initialize(root = nil)
    @root = root
  end

  def build_tree(array)
    sorted_array = array.sort.uniq
    @root = build_branch(sorted_array)
  end

  private

    def build_branch(array)
      node_index = array.size / 2
      node = Node.new(array[node_index])
      return node if node_index.zero?

      node.left_child = build_branch(array[0..node_index - 1])
      node.right_child = build_branch(array[node_index + 1..-1])
      node
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

tree = Tree.new
tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p tree.root
