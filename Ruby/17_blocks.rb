# Single-line block
[1,2,3].each { |num| puts num }

# Multi-line block
[1,2,3].each do |num|
  puts num
end

# Yield
# 
# yield is a keyword that can be called inside a method to relinquish execution to the accompanying block.

def logger
yield
end

logger { puts 'hello from the block' }
#=> hello from the block

logger do
  p [1,2,3]
end
#=> [1,2,3]


def double_vision
  yield
  yield
end

double_vision { puts "How many fingers am I holding up?" }
#=> How many fingers am I holding up?
#=> How many fingers am I holding up?


def love_language
  yield('Ruby')
  yield('Rails')
end

love_language { |lang| puts "I love #{lang}" }
#=> I love Ruby.
#=> I love Rails.


@transactions = [10, -15, 25, 30, -24, -70, 999]

def transaction_statement
  @transactions.each do |transaction|
    yield transaction # You just yield the transaction amount.
  end
end

transaction_statement do |transaction|
  p "%0.2f" % transaction # The bank that calls the method can define how it is handled.
end
#=> ["10.00", "-15.00", "25.00", "30.00", "-24.00", "-70.00", "999.00"]


@transactions = [10, -15, 25, 30, -24, -70, 999]

def transaction_statement
  formatted_transactions = []
  @transactions.each do |transaction|
    formatted_transactions << yield(transaction)
  end

  p formatted_transactions
end

transaction_statement do |transaction|
  "%0.2f" % transaction
end
#=> ["10.00", "-15.00", "25.00", "30.00", "-24.00", "-70.00", "999.00"]


def awesome_method
  hash = {a: 'apple', b: 'banana', c: 'cookie'}

  hash.each do |key, value|
    yield key, value
  end
end

awesome_method { |key, value| puts "#{key}: #{value}" }
#=> a: apple
#=> b: banana
#=> c: cookie


## Block Control
#
#

def simple_method
  yield
end

simple_method
# => `simple_method': no block given (yield) (LocalJumpError)


def maybe_block
  if block_given?
    puts "block party"
  end
  puts "executed regardless"
end

maybe_block
# => executed regardless

maybe_block {} # {} is just an empty block
# => block party
# => executed regardless


## Lambdas
#
# A lambda is a way to write a block and save it to a variable. 
# This can be useful if you’re calling different methods but passing in the same block to each of them. 
# It keeps you from having to type out the same code over and over again.


my_lambda = lambda { puts "my lambda" }

my_other_lambda = -> { puts "hello from the other side" }


my_name = ->(name) { puts "hello #{name}" }

my_age = lambda { |age| puts "I am #{age} years old" }


my_name.call("tim")
#=> hello tim
my_age.call(78)
#=> I am 78 years old


my_name = ->(name) { puts "hello #{name}" }

my_name.call("tim")
my_name.("tim")
my_name["tim"]
my_name.=== "tim"


## Procs
#
# A proc is just an object that you can use to store blocks and pass them around like variables.
# If you think this sounds a bit like a lambda, then you’d be right. In fact, there is no special lambda class.
# A lambda is actually just a type of proc object but with some distinct behaviors which we’ll cover shortly.
#

a_proc = Proc.new { puts "this is a proc" }

a_proc.call
#=> this is a proc


a_proc = proc { puts "this is a proc" }

a_proc.call
#=> this is a proc


a_proc = Proc.new { |name, age| puts "name: #{name} --- age: #{age}" }

a_proc.call("tim", 80)
#=> name: tim --- age: 80

## Procs vs Lambdas
#
# Arguments
#
# A proc behaves much like a block with regards to arguments. 
# A proc doesn’t care if you pass in fewer or more arguments than you specify.
# In fact, it doesn’t care if you don’t pass in any arguments at all. 
# It will assign nil to any parameters you name but don’t pass through as arguments.
#
a_proc = Proc.new { |a, b| puts "a: #{a} --- b: #{b}" }

a_proc.call("apple")
# => a: apple --- b:

# A lambda, on the other hand, DOES care and will raise an error if you don’t honor the number of parameters expected.
#

a_lambda = lambda { |a, b| puts "a: #{a} --- b: #{b}" }

a_lambda.call("apple")
# => wrong number of Arguments (given 1, expected 2) (ArgumentError)

a_lambda.call("apple", "banana", "cake")
# => wrong number of Arguments (given 3, expected 2) (ArgumentError)

# Returning
#
# When you write an explicit return inside a lambda, it returns from the lambda block back to the caller.
# 

a_lambda = -> { return 1 }

a_lambda.call
# => 1

# A proc object, however, returns from the context in which it is called. 
# If you are in the top level context (outside of a class or method), 
# then you’ll get an error because you can’t return out of the very top level context, 
# as there is no caller to return to.
# 

a_proc = Proc.new { return }

a_proc.call
# => localJumpError (unexpected return)

## Similarities

# Default Arguments
# Both procs and lambdas support default arguments in the same way Ruby methods do:

my_proc = Proc.new { |name="bob"| puts name }

my_proc.call
# => bob

my_lambda = ->(name="r2d2") { puts name }

my_lambda.call
# => r2d2

# Method Arguments
# Both procs and lambdas can be used as arguments to a method.
# 
def my_method(useful_arg)
  useful_arg.call
end

my_lambda = -> { puts "lambda" }
my_proc = Proc.new { puts "proc" }

my_method(my_lambda)
# => lambda

my_method(my_proc)
# => proc

## Capturing Blocks
# Ruby allows us to capture blocks in a method definition as a special argument using &.
# 

def cool_method(&my_block)
  my_block.call
end

cool_method { puts "cool" }


def cool_method
  yield
end

my_proc = Proc.new { puts "proc party" }

cool_method(&my_proc)
# => proc party


def cool_method(an_arg)
  an_arg.call
end

a_proc = Proc.new { puts "procodile hunter" }

cool_method(&a_proc) # Converting the proc object to a block

# => ArgumentError (wrong number of arguments (given 0, expected 1))
