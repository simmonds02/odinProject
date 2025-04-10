### Predicate Enumerables
# a predicate method is indicated by a question mark (?) at the end of the method name and returns either true or false

## Include (.include?)
# This method will return true if the element you pass as an argument to #include? exists in the array or hash;
# otherwise, it will return false
numbers = [5, 6, 7, 8]

numbers.include?(6)
#=> true

numbers.include?(3)
#=> false

friends = %w[Sharon Leo Leila Brian Arun]

invited_list = friends.select { |friend| friend != 'Brian' }

invited_list.include?('Brian')
#=> false

## Any (.any)
# returns true if any elements in your array or hash match the condition within the block;
# otherwise, it will return false
numbers = [21, 42, 303, 499, 550, 811]

numbers.any? { |number| number > 500 }
#=> true

numbers.any? { |number| number < 20 }
#=> false

## All (.all)
# returns true if all the elements in your array or hash match the condition you set within the block;
# otherwise, it will return false
fruits = %w[apple banana strawberry pineapple]

fruits.all? { |fruit| fruit.length > 3 }
#=> true

fruits.all? { |fruit| fruit.length > 6 }
#=> false

## None (.none)
# returns true only if the condition in the block matches none of the elements in your array or hash;
# otherwise, it returns false
fruits = %w[apple banana strawberry pineapple]

fruits.none? { |fruit| fruit.length > 10 }
#=> true

fruits.none? { |fruit| fruit.length > 6 }
#=> false
