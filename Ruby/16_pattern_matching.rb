# Ruby 3.1 Pattern Matching Syntax
# 
# Basics

grade = 'C'

case grade
in 'A' then puts 'Amazing effort'
in 'B' then puts 'Good work'
in 'C' then puts 'Well done'
in 'D' then puts 'Room for improvement'
else puts 'See me'
end

# => Well done

# experimental
login = { username: 'hornby', password: 'iliketrains' }

login => { username: username }

puts "Logged in with username #{username}"

#=> Logged in with username hornby

# Patterns
# There are multiple ways of potentially matching against an input. Patterns can be:

# Any Ruby object which is matched using ===. The Object Pattern.
# 
# A variable capture / Variable Pattern
# An As Pattern
# An Alternative Pattern
# A Guard Condition
# An Array Pattern
# A Hash Pattern
# 
# You can use the above patterns while also having the following experimental additions.
# Rightward Assignment
# A Find Pattern
# 
# Object Pattern Match
# 

input = 3

case input
in String then puts 'input was of type String'
in Integer then puts 'input was of type Integer'
end

#=> input was of type Integer

# Variable pattern
# 

age = 15

case age
in a
  puts a
end

# => 15


a = 5

case 1
in a
  a
end

puts a
#=> 1


a = 5

case 1
in ^a
  :no_match
end

#=> NoMatchingPatternError

# As pattern match

case 3
in 3 => a
  puts a
end

# => 3

# Alternative pattern match

case 0
in 0 | 1 | 2
  puts :match
end

# => match

# Guard conditions

some_other_value = true

case 0
in 0 if some_other_value
  puts :match
end

# => match

# Array pattern match

arr = [1 ,2]

case arr
in [1, 2] then puts :match
in [3, 4] then puts :no_match
end

# => match


arr = [1, 2]

case arr
in [Integer, Integer]
  puts :match
in [String, String]
  puts :no_match
end

# => match


arr = [1, 2, 3]

case arr
in [Integer, Integer]
  puts :no_match
end

# => [1, 2, 3] (NoMatchingPatternError)


arr = [1, 2, 3]

case arr
in [Integer, Integer, *]
  puts :match
end

# => match


arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

case arr
in [Integer, Integer, *, Integer, Integer]
  puts :match
end

# => match


arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

case arr
in [Integer, Integer, *, 9, 10]
  puts :match
end

# => match


arr = [1, 2, 3, 4]

case arr
in [1, 2, *tail]
  p tail
end

# => [3, 4]


arr = [1, 2, 3, 4]

case arr
in [_, _, 3, 4]
  puts :match
end

# => match


arr = [1, 2]
case arr
in [a, b] unless a == b
  puts :match
end

# => match


arr = [1, 2, [3, 4]]

case arr
in [_, _, [3, 4]]
  puts :match
end

# => match


case [1, 2, 3, [4, 5]]
in [1, 2, 3, [4, a] => arr]
  puts a
  p arr
end

# => 5
# => [4, 5]


arr = [1, 2, 3]

case [1, 2, 4]
in arr
  :match
end

p arr

# => [1, 2, 4]


arr = [1, 2, 3, 4]

case arr
in 1, 2, 3, 4
  puts :match
end

# => match

# Hash pattern matching

case { a: 'apple', b: 'banana' }
in { a: 'aardvark', b: 'bat' }
  puts :no_match
in { a: 'apple', b: 'banana' }
  puts :match
end

# => match


case { a: 'apple', b: 'banana' }
in { a: a, b: b }
  puts a
  puts b
end

# => apple
# => banana


case { a: 'apple', b: 'banana' }
in { a:, b: }
  puts a
  puts b
end

# => apple
# => banana


case { a: 'apple', b: 'banana' }
in a:, b:
  puts a
  puts b
end

# => apple
# => banana


case { a: 'ant', b: 'ball', c: 'cat' }
in { a: 'ant', **rest }
  p rest
end

# => { :b => "ball", :c => "cat" }


case { a: 'ant', b: 'ball' }
in { a: 'ant' }
  'this will match'
in { a: 'ant', b: 'ball' }
  'this will never be reached'
end


case { a: 'ant', b: 'ball' }
in { a: 'ant', **nil }
  puts :no_match
in { a: 'ant', b: 'ball' }
  puts :match
end

# => match


case { a: 'ant', b: 'ball' }
in { a: 'ant' } => hash
  p hash
end

#=> { :a => 'ant', :b => 'ball' }

## Ruby 3
#
# Rightward assignment

login = { username: 'hornby', password: 'iliketrains' }

login => { username: username }

puts "Logged in with username #{username}"

#=> "Logged in with username hornby"

# Find Pattern
# 

case [1, 2, 3]
in [*pre, 1, 2, 3, *post]
  p pre
  p post
end

# => []
# => []

 
case [1, 2, 3, 4, 5]
in [*pre, 2, 3, *post]
  p pre
  p post
end

# => [1]
# => [4, 5]


case [1, 2, "a", 4, "b", "c", 7, 8, 9]
in [*pre, String => x, String => z, *post]
  p pre
  p x
  p z
  p post
end

# => [1, 2, "a", 4]
# => "b"
# => "c"
# => [7, 8, 9]


name = 'Jill'
age = 32
job_title = 'leet coder'

case data
in [*, { name: ^name, age: ^age, first_language: first_language, job_title: ^job_title }, *]
else
  first_language = nil
end

puts first_language

# => italian
