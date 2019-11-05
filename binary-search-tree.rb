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

  def find(value)
    return false if @root.nil?

    node = @root
    until node.nil?
      return node if value == node.data

      node = value < node.data ? node.left : node.right
    end
    false
  end

  def level_order
    return nil if @root.nil?

    queue = [@root]
    values = []
    until queue.empty?
      node = queue.first
      yield node if block_given?
      values << queue.shift.data
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    values
  end

  def preorder(node = @root, &block)
    return nil if node.nil?

    values ||= []
    yield node if block_given?
    values.push(node.data)
    values.push(*preorder(node.left, &block))
    values.push(*preorder(node.right, &block))

    values
  end

  def inorder(node = @root, &block)
    return nil if node.nil?

    values ||= []
    values.push(*inorder(node.left, &block))
    yield node if block_given?
    values.push(node.data)
    values.push(*inorder(node.right, &block))

    values
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
tree.preorder { |node| puts "#{node.data}!" }
p tree.preorder
tree.inorder { |node| puts "#{node.data}!" }
p tree.inorder

