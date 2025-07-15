require './linked_list/linked_list.rb'


class HashMap
    attr_accessor :load_factor, :capacity, :buckets

    def initialize(load_factor = 0.8, capacity = 16)
        self.load_factor = load_factor
        self.capacity = capacity
        self.buckets = Array.new(capacity) {|x| LinkedList.new()}
    end

    def hash(key)
     if key.is_a?(String)

        hash_code = 0
        prime_number = 31
      
        key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
      
        hash_code
     else
        puts "Key must be a string.... Try Again"
     end
    end

    def set(key, value)
        #get hash key
        new_hash_code = hash(key)
        # modulo for # of buckets
        desired_bucket = new_hash_code % self.capacity
        #create new node
        new_node = Node.new(value, key)
        # check for linked list
        # puts desired_bucket
        list = buckets[desired_bucket]
        # if linked list is empty
        if list.head.nil?
            # add node to list
            list.head = new_node
            list.tail = new_node
            # puts "List was empty, adding as head with value #{value} and key #{key}"
        # if linked list is not empty
        else
            # get list size
            list_size = list.size
            # does set key match node key
            temp_node = list.head
            (0...list_size).each do
                if temp_node.key == key
                    #update value
                    temp_node.value = value
                    break
                elsif temp_node.next_node.nil?
                    temp_node.next_node = new_node
                    break
                end
                temp_node = temp_node.next_node    
            end
        end
        self.grow_hashmap
    end

    def get(key)
    # get(key) takes one argument as a key and returns the value
    # that is assigned to this key. 
    # If key is not found, return nil.  
        #get hash key
        new_hash_code = hash(key)
        # modulo for # of buckets
        desired_bucket = new_hash_code % self.capacity
        this_list = buckets[desired_bucket]
        temp_node = this_list.head
        while !temp_node.nil?
            if temp_node.nil?
                puts "List is Empty, no value to get"
            elsif temp_node.key == key
                return temp_node.value
            else
                temp_node = temp_node.next_node
            end
        end
        return nil
    end

    def has?(key)
    # has?(key) takes a key as an argument and returns true or false 
    # based on whether or not the key is in the hash map.  
        #get hash key
        new_hash_code = hash(key)
        # modulo for # of buckets
        desired_bucket = new_hash_code % self.capacity
        this_list = buckets[desired_bucket]
        temp_node = this_list.head
        if temp_node.nil?
            puts "List is Empty, no key found"
            return false
        else
            while !temp_node.nil?
                if temp_node.key == key
                    return true
                else
                    temp_node = temp_node.next_node
                end
            end
            return false
        end
        
    end

    def remove(key)
        # remove(key) takes a key as an argument. 
        # If the given key is in the hash map, it should remove the entry with that key and return the deleted entry’s value. 
        # If the key isn’t in the hash map, it should return nil.
         #get hash key
        new_hash_code = hash(key)
        # modulo for # of buckets
        desired_bucket = new_hash_code % self.capacity
        this_list = buckets[desired_bucket]
        temp_node = this_list.head
        previous_node = nil
        if this_list.nil?
            puts "Key not found in HashMap"
            return nil
        else
            while !temp_node.nil?
                if temp_node.key == key
                    # get value
                    temp_node_value = temp_node.value

                    # if head
                    if temp_node == this_list.head
                        this_list.head = temp_node.next_node
                    # if tail
                    elsif temp_node == this_list.tail
                        previous_node.next_node = nil  
                    # if middle
                    else                    
                        # delete node
                        previous_node.next_node = temp_node.next_node
                    end

                    # return value
                    return temp_node_value
                else
                previous_node = temp_node
                temp_node = temp_node.next_node
                end
            end
            return nil
        end
        
    end

    def length
        #use capacity to loop through all lists
        count = 0
        buckets.each do |bucket|
            if bucket.head.nil?
                next
            else
                temp_node = bucket.head
                while !temp_node.nil?
                    count += 1
                    temp_node = temp_node.next_node
                end
            end
        end
        return count
    end

    def clear
        buckets.each do |bucket|
            if bucket.head.nil?
                next
            else
                bucket.head = nil
                bucket.tail = nil
            end
        end          
    end

    def keys
        key_arr = Array.new()
        buckets.each do |bucket|
            if bucket.head.nil?
                next
            else
                temp_node = bucket.head
                while !temp_node.nil?
                    key_arr << temp_node.key
                    temp_node = temp_node.next_node
                end
            end
        end
        return key_arr
    end

    def values
        values_arr = Array.new()
        buckets.each do |bucket|
            if bucket.head.nil?
                next
            else
                temp_node = bucket.head
                while !temp_node.nil?
                    values_arr << temp_node.value
                    temp_node = temp_node.next_node
                end
            end
        end
        return values_arr
    end

    def entries
        entries_arr = Array.new()
        buckets.each do |bucket|
            if bucket.head.nil?
                next
            else
                temp_node = bucket.head
                while !temp_node.nil?
                    entries_arr << [temp_node.key, temp_node.value]
                    temp_node = temp_node.next_node
                end
            end
        end
        return entries_arr
    end

    def grow_hashmap
        if self.length > (self.load_factor * self.capacity)
            puts "Growing HashMap"
            # puts self.load_factor
            # puts self.capacity
            # increase capacity by factor of 2
            self.capacity = self.capacity * 2
            # copy all node over
            temp_arr_entries = self.entries
            new_buckets = Array.new(self.capacity) {|x| LinkedList.new()}
            self.buckets = new_buckets
            temp_arr_entries.each do |key, value|
                self.set(key,value)                 
            end
        end
    end

end

