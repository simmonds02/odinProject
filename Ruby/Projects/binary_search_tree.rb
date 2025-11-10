

class Node
  include Comparable

  attr_accessor :data, :left_node, :right_node
    
  def initialize(data = nil, left_node = nil, right_node = nil)
    self.data = data
    self.left_node = left_node
    self.right_node = right_node
  end
end



class Tree
  attr_accessor :array, :root
    
  def initialize(array = nil)
    self.array = array
    self.root = build_tree(self.array)
  end

  def build_tree(array)
    return sortedArrayToBSTRecur(array, 0, array.length - 1)
  end

  def sortedArrayToBSTRecur(array, arr_start, arr_end)
    if arr_start > arr_end
      return nil  
    end
    # Find Middle
    mid = arr_start + ( (arr_end - arr_start) / 2 ).floor()
    # Create Root
    root = Node.new(array[mid])
    root.left_node = sortedArrayToBSTRecur(array, arr_start, mid - 1)
    root.right_node = sortedArrayToBSTRecur(array, mid + 1, arr_end)
    return root
  end

  def pretty_print(node = self.root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end

  def preOrder(root)
    if root == nil
      return nil
    end
    puts root.data;
    preOrder(root.left_node);
    preOrder(root.right_node);
  end

  def insert(data, root = nil)
    if root.nil?
      return Node.new(data)
    end

    if root.data == data
      puts "Node matching data was found. No duplicates allowed"
      return root
    elsif data < root.data
      root.left_node = insert(data, root.left_node)
    elsif root.data < data
      root.right_node = insert(data, root.right_node)
    end
    return root
  end

  def getSuccessor(node)
    node = node.right_node
    while !node.nil? && !node.left_node.nil?
      node = node.left_node
    end
    return node
  end

  def remove(data, root)
    if root.nil?
      return root
    end
    if root.data > data
      root.left_node = remove(data, root.left_node)
    elsif root.data < data
      root.right_node = remove(data, root.right_node)
    else
      if root.left_node == nil
        return root.right_node
      elsif root.right_node == nil
        return root.left_node
      end
      succ = getSuccessor(root)
      root.data = succ.data
      root.right_node = remove(succ.data, root.right_node)
    end
    return root
  end

  def find(data)
    root = self.root
    if root.nil?
      puts "No root found, please provide to execute find method"
      return root
    end

    while (root == nil) || (root.data != data)
      if root.nil?
        puts "Data not found in tree"
        return root
      elsif data < root.data
        root = root.left_node
      elsif data > root.data
        root = root.right_node
      end
    end
    return root
  end

  def level_order
    myArray = Array.new()
    result = Array.new()
    root = self.root
    myArray << root

    # loop for visiting and enqueue children
    while (myArray.length > 0)
      # visit first element
      temp_node = myArray.shift
      if block_given?
        yield(temp_node)
      else
        result << temp_node.data          
      end
      myArray << temp_node.left_node unless temp_node.left_node.nil?
      myArray << temp_node.right_node unless temp_node.right_node.nil?
    end
    
    unless block_given?
      return result
    end
  end

  def inOrder
    myArray = Array.new()
    result = Array.new()
    temp_node = self.root
    
    loop do
      if temp_node.nil?
        temp_node = myArray.pop
        if block_given?
          yield(temp_node)
        else
          result << temp_node.data
        end
        temp_node = temp_node.right_node
      else
        myArray << temp_node
        temp_node = temp_node.left_node 
      end
      break if ( myArray.length <= 0 && temp_node == nil)
    end
    return result
  end

  def preOrderLoop
    myArray = Array.new()
    result = Array.new()
    temp_node = self.root
    myArray << temp_node
    
    while (myArray.length > 0)
      if temp_node.nil?
        temp_node = myArray.pop
        # add block and test
      else
        result << temp_node.data
        myArray << temp_node.right_node
        temp_node = temp_node.left_node
      end
    end
    return result
  end


  def preOrderLoop
    myArray = Array.new()
    result = Array.new()
    temp_node = self.root
    myArray << temp_node
    
    while (myArray.length > 0)
      if temp_node.nil?
        temp_node = myArray.pop
        # add block and test
      else
        result << temp_node.data
        myArray << temp_node.right_node
        temp_node = temp_node.left_node
      end
    end
    return result
  end

  def postOrderLoop
    myArray = Array.new()
    result = Array.new()
    temp_node = self.root
    
    while ( !temp_node.nil? || myArray.length > 0 )
      while( !temp_node.nil? )
        if ( !temp_node.right_node.nil? )
          myArray << temp_node.right_node
        end
        myArray << temp_node
        temp_node = temp_node.left_node
      end

      temp_node = myArray.pop

      if(myArray.length > 0 && !temp_node.right_node.nil? && myArray[(myArray.length) - 1 ] == temp_node.right_node)
        myArray.pop
        myArray << temp_node
        temp_node = temp_node.right_node
      else
        result << temp_node.data
        temp_node = nil
      end
    end
    return result
  end

  def depth(value)
    temp_node = self.root
    count = 0
    while (temp_node == nil || value != temp_node.data)
      if temp_node.nil?
        puts "Value not found in tree, please try again"
        return nil
      elsif value > temp_node.data
        temp_node = temp_node.right_node
        count += 1
      elsif value < temp_node.data
        temp_node = temp_node.left_node
        count += 1
      end
    end
    return count
  end

  def height_recursive(node)
    if node.nil?
      return -1
    end
    return ( 1 + [ height_recursive(node.left_node) , height_recursive(node.right_node) ].max )
  end

  def height(value)
    value_node = self.find(value)
    if value_node.nil?
      puts "Value not found in tree, please try again"
        return nil
    end
    return self.height_recursive(value_node)
  end

  def balanced?
    temp_node = self.root
    my_array = Array.new()
    my_array << temp_node

    while( my_array.length > 0 )
      if(temp_node.nil?) 
        temp_node = my_array.pop
        next
      end

      height_diff = ((self.height_recursive(temp_node.left_node)) - (self.height_recursive(temp_node.right_node))).abs

      if (height_diff > 1)
        return false
      else
        my_array << temp_node.right_node
        temp_node = temp_node.left_node
      end
    end
    return true
  end

  def rebalance
    if self.balanced?
      puts "Tree is already balanced"
      return self
    end  
    new_array = self.inOrder
    sorted_array = new_array.sort
    new_tree = Tree.new(sorted_array)
    new_tree.pretty_print(new_tree.root)
    puts "Done rebalancing tree"
    return new_tree
  end


end



test_array = [1, 2, 3, 4]

test_tree = Tree.new(test_array)

some_root = test_tree.root

test_tree.pretty_print(some_root)

test_tree.preOrder(some_root)

test_tree.insert(55, some_root)

test_tree.insert(5, some_root)

test_tree.insert(0, some_root)

test_tree.insert(1, some_root)

test_tree.pretty_print(some_root)

test_tree.preOrder(some_root)

test_tree.pretty_print(some_root)

test_tree.remove(5, some_root)

test_tree.pretty_print(some_root)

test_tree.remove(1, some_root)

test_tree.pretty_print(some_root)

test_tree.remove(2, some_root)

test_tree.pretty_print(some_root)

test_tree.preOrder(some_root)

p test_tree.find(55)

p test_tree.find(3)

p test_tree.find(4)

p test_tree.find(0)

puts test_tree.find(5)

puts test_tree.level_order

# test_tree.level_order{ |node| puts node.data}

# puts test_tree.inOrder

# test_tree.pretty_print(some_root)

# puts test_tree.preOrderLoop

# test_tree.pretty_print(some_root)

# puts test_tree.postOrderLoop

# test_tree.pretty_print(some_root)

# puts test_tree.height_recursive(some_root)

# puts test_tree.height_recursive(test_tree.find(0))

# puts test_tree.height(2)

# puts test_tree.height(0)

# puts test_tree.height(33)

# puts test_tree.balanced?

# test_tree.insert(54, some_root)

# test_tree.insert(7, some_root)

# test_tree.insert(13, some_root)


# test_tree.insert(2, some_root)


# test_tree.pretty_print(some_root)

# puts test_tree.balanced?

# Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
randomArray = (Array.new(15) { rand(1..100) })
newTree = Tree.new(randomArray)
newRoot = newTree.root
# Confirm that the tree is balanced by calling #balanced?
puts newTree.balanced?
# Print out all elements in level, pre, post, and in order
newTree.pretty_print(newRoot)
puts newTree.level_order
newTree.pretty_print(newRoot)
puts newTree.inOrder
newTree.pretty_print(newRoot)
puts newTree.preOrderLoop
newTree.pretty_print(newRoot)
puts newTree.postOrderLoop
# Unbalance the tree by adding several numbers > 100
newTree.insert(103, newRoot)
newTree.insert(413, newRoot)
newTree.insert(132, newRoot)
newTree.insert(199, newRoot)
newTree.pretty_print(newRoot)
# Confirm that the tree is unbalanced by calling #balanced?
puts newTree.balanced?
# Balance the tree by calling #rebalance
newTree = newTree.rebalance
newRoot = newTree.root
newTree.pretty_print(newRoot)
# Confirm that the tree is balanced by calling #balanced?
puts newTree.balanced?
# Print out all elements in level, pre, post, and in order.
newTree.pretty_print(newRoot)
puts newTree.level_order
newTree.pretty_print(newRoot)
puts newTree.inOrder
newTree.pretty_print(newRoot)
puts newTree.preOrderLoop
newTree.pretty_print(newRoot)
puts newTree.postOrderLoop
