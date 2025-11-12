

def knight_moves(origin, destination)
  # make sure inputs are arrays
  unless ( origin.is_a?(Array) && destination.is_a?(Array) )
    puts " Inputs must be an array of coordinates, Please Try Again"
    return nil
  end

  my_queue = Array.new()
  visited = Array.new(8){ |i| Array.new(8){ |j| false } }
  my_queue << origin
  visited[origin[0]][origin[1]] = true
  current_node = []

  move_options = [[2,1],[1,2],[-2,-1],[-1,-2],[-2,1],[-1,2],[2,-1],[1,-2]]

  prev = Array.new(8){ |i| Array.new(8){ |j| nil } }

  
  while( !my_queue.empty? )
    # Get node from front of queue
    current_node = my_queue.shift
    # puts "Current Node - #{current_node}"
    # Get all next options
    current_options = move_options.map{|a, b| [ a + current_node[0], b + current_node[1] ]}
                                  .select{|a,b| (a>=0 && 7>=a) && (b>=0 && 7>=b)}
    # If next Option has NOT been visited, enqueue
    current_options.each do |node_option| 
      if !visited[node_option[0]][node_option[1]]
        my_queue << node_option
        visited[node_option[0]][node_option[1]] = true
        prev[node_option[0]][node_option[1]] = current_node
      end
    end
    if destination == current_node
      break
    end
  end

  path = Array.new()
  last_prev_node = prev[destination[0]][destination[1]]
  path << current_node

  while ( !last_prev_node.nil? )
    path << last_prev_node
    last_prev_node = prev[last_prev_node[0]][last_prev_node[1]]
  end

  path.reverse!

  if path[0] == origin
    p "You made it in #{(path.length-1)} move(s)! Here's you path:"
    path.each{|i| p i}    
  end
end

knight_moves([0,0], [1,2])


knight_moves([0,0], [3,3])
 

knight_moves([3,3], [0,0])


knight_moves([0,0],[7,7])
