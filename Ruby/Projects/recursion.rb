# Code Quizzes
# 
# Recursion
# 


# Define a recursive function that finds the factorial of a number.

def my_fact(n)
    if n == 1
      return 1
    end

    return n * my_fact( n-1 )

end

# puts my_fact(3)


# Define a recursive function that returns true if a string is a palindrome and false otherwise.

def my_palindrome(string)
  # base case = does reverse == original
  # base case = string length <= 1
  if string.length <= 1
    return true
  end

  # recursive case = does first == last
  if string[0] == string[-1]
    my_palindrome(string[1..-2])
  else
    return false
  end
end

# puts my_palindrome("abbba")


# Define a recursive function that takes an argument n and prints "n bottles of beer on the wall",
# "(n-1) bottles of beer on the wall", ..., "no more bottles of beer on the wall".

def my_bottles(n)
    if n == 0
      puts "no more bottles of beer on the wall"     
      return   
    end
    puts "#{n} bottles of beer on the wall"
    my_bottles(n-1)
end

# my_bottles(20)

# Define a recursive function that takes an argument n and returns the fibonacci value of that position. 
# The fibonacci sequence is 0, 1, 1, 2, 3, 5, 8, 13, 21... So fib(5) should return 5 and fib(6) should return 8.

def my_fib(position)
    if position == 0
      return 0
    elsif position == 1
      return 1
    end
    return my_fib(position - 1) + my_fib(position - 2)
end

# puts my_fib(5)
# puts my_fib(6)

# Define a recursive function that flattens an array. 
# The method should convert [[1, 2], [3, 4]] to [1, 2, 3, 4] and [[1, [8, 9]], [3, 4]] to [1, 8, 9, 3, 4].

def my_flat_arr(arr, result = [])
  arr.each do |x|
    if x.is_a?(Array)
      my_flat_arr(x, result)
    else
      result << x
    end  
  end
  return result
end

# arr_2d = [[1, 2], [3, 4]]
arr_2d =  [[1, [8, 9]], [3, 4]]

# p my_flat_arr(arr_2d)


# Use the roman_mapping hash to define a recursive method that converts an integer to a Roman numeral.
# 
 def int_to_roman(num, result = "")
  roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
}

  roman_mapping.each do |x, y|
    if num >= x
      puts "yOUR nUMBER IS #{num} AND ROMAN IS #{y}"
      result.insert(-1, y)
      num -= x
      if num == 0
        break
      end
      int_to_roman(num, result)     
    end      
  end
  return result
 end

#  puts int_to_roman(300)
#  
#


def fibs(num)
    result = Array.new()
    for x in 0...num
      if x == 0
        result << 0
      elsif x == 1
        result << 1
      else
        result << (result[x-2] + result[x-1])
      end            
    end
    p result
end

# fibs(0)
# fibs(1)
# fibs(2)
# fibs(3)
# fibs(4)
# fibs(5)
# fibs(6)
# fibs(7)
# fibs(8)
#
 
# merge sort

def merge_sort(arr, result = [])
  #split until single 
  if arr.length == 1
    return arr
  else
    half = (arr.length / 2)
    # left_result = arr.slice!(0...half)
    left_result = merge_sort(arr.slice!(0...half), result)
    right_result = merge_sort(arr, result)

    # merge_sort(left_result, result)
    # merge_sort(right_result, result)
  end
  # merge halves
  
  i = 0
  j = 0
  final_result = []

  # puts "#{left_result} : Left Result"
  # puts "#{right_result} : Right Result"

  while(i < left_result.length && j < right_result.length)  
    if left_result[i] < right_result[j]
      # p " #{final_result} before append"
      final_result << left_result[i]
      # p "#{i} is the interator for left and #{left_result[i]} is the value"
      # p "and here is that result #{final_result}"
      i += 1
    else
      # p " #{final_result} before append"
      final_result << right_result[j]
      # p "#{j} is the interator for right and #{right_result[j]} is the value"
      # p "and here is that result #{final_result}"
      j += 1
    end
  end
  if i < left_result.length
    left_result.each_with_index do |x, index|
      if index >= i && index < left_result.length
        final_result << x         
      end        
    end      
  end
  if j < right_result.length
    right_result.each_with_index do |x, index|
      if index >= j && index < right_result.length
        final_result << x         
      end        
    end   
  end
  result = final_result
  p result
  return result
end

# test_array = [105, 79, 100, 110]
# test_array = [105, 77]
test_array = [11, 22, 59, 10, 151, 231, 24, 361, 33, 40, 42, 554, 61, 65, 750, 736, 88, 942, 94, 979]

merge_sort(test_array)