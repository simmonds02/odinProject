### Methods
=begin
 ## About why we call functions methods in Ruby
  "Many languages distinguish between functions, which have no associated object, and methods, which are invoked on a receiver object. 
  Because Ruby is a purely object-oriented language, all methods are true methods and are associated with at least one object."
 Basically, because everything in Ruby is an object, Ruby only has methods, not functions. 
 With that established, we know that when we’re talking about Ruby, “methods” and “functions” refer to the same thing.
=end

## Ruby built in Methods
"anything".reverse

puts "anything" #=> anything

## Creating a Method
def my_name
  "Joe Smith"
end

puts my_name    #=> "Joe Smith"

## Method Names

method_name      # valid
_name_of_method  # valid
1_method_name    # invalid
method_27        # valid
method?_name     # invalid
method_name!     # valid
begin            # invalid (Ruby reserved word)
begin_count      # valid

## Parameters and Arguments
def greet(name)
  "Hello, " + name + "!"
end

puts greet("John") #=> Hello, John!

#default parameters
def greet(name = "stranger")
  "Hello, " + name + "!"
end

puts greet("Jane") #=> Hello, Jane!
puts greet #=> Hello, stranger!

## What methods return
# implicit return
def even_odd(number)
  if number % 2 == 0
    "That is an even number."
  else
    "That is an odd number."
  end
end

puts even_odd(16) #=>  That is an even number.
puts even_odd(17) #=>  That is an odd number.

# explicit return
def my_name
  return "Joe Smith"
end

puts my_name #=> "Joe Smith"

def even_odd(number)
  unless number.is_a? Numeric
    return "A number was not entered."
  end

  if number % 2 == 0
    "That is an even number."
  else
    "That is an odd number."
  end
end

puts even_odd(20) #=>  That is an even number.
puts even_odd("Ruby") #=>  A number was not entered.

def my_name
  return "Joe Smith"
  "Jane Doe"
end

puts my_name #=> "Joe Smith"

def even_odd(number)
  unless number.is_a? Numeric
    return "A number was not entered."
  end

  if number % 2 == 0
    "That is an even number."
  else
    "That is an odd number."
  end
end

puts even_odd(20) #=>  That is an even number.
puts even_odd("Ruby") #=>  A number was not entered.

## Puts vs Return
# puts is a method that prints whatever argument you pass it to the console.
# return is the final output of a method that you can use in other places throughout your code.


def puts_squared(number)
  puts number * number
end

def return_squared(number)
  number * number
end

x = return_squared(20) #=> 400
y = 100
sum = x + y #=> 500

puts "The sum of #{x} and #{y} is #{sum}."
#=> The sum of 400 and 100 is 500.

## Chaining Methods
phrase = ["be", "to", "not", "or", "be", "to"]

puts phrase.reverse.join(" ").capitalize
#=> "To be or not to be"

["be", "to", "not", "or", "be", "to"].reverse
= ["to", "be", "or", "not", "to", "be"].join(" ")
= "to be or not to be".capitalize
= "To be or not to be"

## Predicate Methods (?)
# These are all predicate methods, which is a naming convention that Ruby uses for methods that return a Boolean,
# that is, they return either true or false.
puts 5.even?  #=> false
puts 6.even?  #=> true
puts 17.odd?  #=> true

puts 12.between?(10, 15)  #=> true

## Bang Methods (!)
# By adding a ! to the end of your method, you indicate that this method performs its action
# and simultaneously overwrites the value of the original object with the result.
# Writing whisper.downcase! is the equivalent of writing whisper = whisper.downcase.
whisper = "HELLO EVERYBODY"

puts whisper.downcase #=> "hello everybody"
puts whisper #=> "HELLO EVERYBODY"

puts whisper.downcase! #=> "hello everybody"
puts whisper #=> "hello everybody"

## Method calls as arguments
def add(a, b)
  a + b
end

def subtract(a, b)
  a - b
end

add(20, 45)
=> 65
# returns 65

subtract(80, 10)
=> 70
# returns 70

def multiply(num1, num2)
  num1 * num2
end

multiply(add(20, 45), subtract(80, 10))
=> 4550
# returns 4550

add(subtract(80, 10), multiply(subtract(20, 6), add(30, 5)))
=> 560