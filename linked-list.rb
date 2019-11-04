require 'pry'

class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(node)
    return @head = node if @head.nil?

    tail.next_node = node
  end

  def prepend(node)
    node.next_node = @head
    @head = node
  end

  def size
    return 0 if @head.nil?

    current_node = @head
    number_of_nodes = 1
    until current_node.next_node.nil?
      number_of_nodes += 1
      current_node = current_node.next_node
    end
    number_of_nodes
  end

  def tail
    return nil if @head.nil?

    current_node = @head
    current_node = current_node.next_node until current_node.next_node.nil?

    current_node
  end

  def at(index)
    return nil if @head.nil?
    return @head if index.zero?

    current_node = @head
    index.times do
      return nil if current_node.next_node.nil?

      current_node = current_node.next_node
    end
    current_node
  end

  def pop
    return nil if @head.nil?

    current_node = @head
    previous_node = @head
    @head = nil if @head.next_node.nil?

    until current_node.next_node.nil?
      previous_node = current_node
      current_node = current_node.next_node
    end
    previous_node.next_node = nil
    current_node
  end

  def contains?(value)
    return false if @head.nil?

    current_node = @head
    until current_node.next_node.nil?
      return true if current_node.value == value

      current_node = current_node.next_node
    end
    current_node.value == value
  end

  def find(value)
    return nil if @head.nil?

    current_node = @head
    index = 0
    until current_node.next_node.nil?
      return index if current_node.value == value

      current_node = current_node.next_node
      index += 1
    end
    return index if current_node.value == value

    nil
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize
    @value = nil
    @next_node = nil
  end
end

# list = LinkedList.new

# node1 = Node.new
# node1.value = 1
# list.prepend node1

# node2 = Node.new
# node2.value = 2
# list.append node2

# node3 = Node.new
# node3.value = 3
# list.append node3

# node4 = Node.new
# node4.value = 4
# list.prepend node4
