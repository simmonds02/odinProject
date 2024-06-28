  
  
  def bubble_sort(array = Array.new)
    # take array and start sort
    (array.length - 1).times do
      sortIndex = 0
      while sortIndex < (array.length - 1)
      # check if current is less than element to the right of index
        if array[sortIndex] > array[sortIndex+1]
          temp = array[sortIndex]
          array[sortIndex] = array[sortIndex+1]
          array[sortIndex+1] = temp
        end
        sortIndex+=1
      end
    end
    p array
  end



bubble_sort([4,3,78,2,0,2,10,34,7,15,46,99,04,22])