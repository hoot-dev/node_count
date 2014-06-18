class Node
  attr_accessor :first_child, :next_sibling

  def initialize
    @first_child = nil
    @next_sibling = nil
    @descendent_count = 0
  end

  # Public: Breadth first traversal of the node structure to determine descendents
  #
  # node  - A Node object
  #
  # Returns: A count of descendents of the given node
  def count_descendents(node)
    list = []
    add_node(list, node.first_child) if node.first_child != nil
    add_node(list, node.next_sibling) if node.next_sibling != nil
    loop do
      break if list.empty?
      node = list.shift
      add_node(list, node.first_child) if node.first_child != nil
      add_node(list, node.next_sibling) if node.next_sibling != nil
    end

    return @descendent_count
  end

  # Test method to ensure traversal is working
  def insert
    list = []
    if @first_child == nil
      @first_child = Node.new
    elsif @next_sibling == nil
      @next_sibling = Node.new
    else
      list << @first_child
      list << @next_sibling
      loop do
        node = list.shift
        if node.first_child == nil
          node.insert
          break
        else
          list << node.first_child
        end
        if node.next_sibling == nil
          node.insert
          break
        else
          list << node.next_sibling
        end
      end
    end
  end

  private

  attr_reader :descendent_count # currently only exposing this via count_descendents

  # Private: Adds a node to a list an increments the descendent count
  #
  # list - An Array of Node objects
  def add_node(list, node)
    list << node
    @descendent_count += 1
  end
end


# Simple test to ensure code is working
node = Node.new
(1..20).each { |x| node.insert }

# This should show 20 descendents
puts node.count_descendents(node)
