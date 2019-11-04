class Tree
  attr_reader :root

  def initialize(root = nil)
    @root = root
  end

  def build_tree(array)
  end

  private

    def build_branch(array)
      node_index = array.size / 2
      node = new Node(array[node_index])
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
