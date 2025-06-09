

class LinkedList

  attr_accessor :head, :tail, :name


  def initialize(head = nil, tail = nil)
    self.head = head
    self.tail = tail      
  end

  #1
  def append(value)
    # create new node
    new_node = Node.new(value)
    # if list empty, new node assigned to head and tail
    if self.head.nil?
      self.head = new_node
      self.tail = new_node
      puts "no head, adding as head with value #{value} and node #{new_node}"
    else
      # if list not empty,
      # current tail points to new node
      self.tail.next_node = new_node
      # new tail becomes new value
      self.tail = new_node
      puts "new node added with value #{value} and node #{new_node}"
    end
  end

  #2
  def prepend(value)
    # create new node from value
    new_node = Node.new(value)
    # if list empty, new node assigned to head and tail
    if self.head.nil?
      self.head = new_node
      self.tail = new_node
    else
      # if list not empty,
      # old head = new node's next node
      new_node.next_node = self.head
      # new head =  new node
      self.head = new_node
    end
  end

  #3
  def size
    count = 0
    if self.head.nil?
      return 0
    else
      temp_node = self.head
      while !temp_node.nil?
        count += 1
        temp_node = temp_node.next_node
      end
      return count
    end
  end

  #4
  def self.head
    puts self.head
  end

  # # #5
  def self.tail
    puts self.tail
  end

  #6
  def at(index)
    if self.head.nil?
      puts "List is Empty"
      return nil
    elsif (index > self.size - 1)
      puts "requested index is larger than list size"
    else
      # if list is not empty
      # start counting from first node
      # when count == index, return node
      temp_node = self.head
      (0...index).each do
        temp_node = temp_node.next_node    
      end
    end
    return temp_node
  end

  #7
  def pop
    if self.head.nil?
      puts "List is Empty"
      return nil
    else
      # if list not empty,
      # get list size
      list_size = self.size
      # grab current tail
      temp_node = self.tail
      # set new tail and remove next_node
      self.tail = self.at(list_size - 2)
      self.tail.next_node = nil
      # return OG tail
      return temp_node
    end
  end

  #8
  def contains?(value)
    if self.head.nil?
      puts "List is Empty"
    else
      temp_node = self.head
      while !temp_node.nil?
        if temp_node.value == value
          return true
        else
          temp_node = temp_node.next_node    
        end         
      end
    end
    return false
  end

  #9
  def find(value)
    count = 0
    if self.head.nil?
      puts "List is Empty"
    else
      temp_node = self.head
      while !temp_node.nil?
        if temp_node.value == value
          return count
        else
          temp_node = temp_node.next_node    
        end  
        count += 1      
      end
    end
    return nil
  end

  #10
  def to_s
    if self.head.nil?
      puts "List is Empty"
    else
      l_list = ''
      temp_node = self.head
      while !temp_node.nil?
        l_list << "( #{temp_node.value} ) -> "
        temp_node = temp_node.next_node        
      end
      l_list << 'nil'
      return l_list
    end
  end

  #11
  def insert_at(value, index)
    # create new node
    new_node = Node.new(value)
    if self.head.nil?
      puts "List is Empty"
    elsif (index > self.size - 2)
      puts "requested index is larger than list size"
    else
      temp_node = self.head
      (0...(index - 1)).each do
        temp_node = temp_node.next_node    
      end
      new_node.next_node = temp_node.next_node
      temp_node.next_node = new_node
    end
  end

  #12
  def remove_at(index)
    # create new node
    if self.head.nil?
      puts "List is Empty"
    elsif (index > self.size - 2)
      puts "requested index is larger than list size"
    else
      temp_node = self.head
      (0...(index - 1)).each do
        temp_node = temp_node.next_node    
      end
      temp_node.next_node = temp_node.next_node.next_node
    end
  end

end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)  
        self.value = value
        self.next_node = next_node
  end

end