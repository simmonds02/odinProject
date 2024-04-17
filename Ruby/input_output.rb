### Input and Output

## Output
# puts and print attempts to convert everything into a string (by calling to_s).

# print
irb(main):001:0> print "Learning to code is FUN!"
Learning to code is FUN!=> nil

irb(main):002:0> print "1234"
1234=> nil


# puts (append a new line to anything printed to terminal)

irb(main):001:0> puts "Learning to code is cool!!"
Learning to code is cool!!
=> nil

irb(main):002:0> puts "Hey, I want 2 key lime pies."
Hey, I want 2 key lime pies.
=> nil

irb(main):003:0> x = "My name is ALEX! :)"
=> "My name is ALEX! :)"

irb(main):004:0> puts x
My name is ALEX! :)
=> nil

# example

irb(main):001:0> print "Hello World"; print "I love drinking coffee"
Hello WorldI love drinking coffee=> nil

irb(main):002:0> puts "Hello World"; puts "I love drinking coffee"
Hello World
I love drinking coffee
=> nil

# Arrays
puts [1,2]
1
2

print [1,2]
[1,2]

#p
#shows a more “raw” version of an object
#returns the object you pass to it
> puts "Ruby Is Cool"
Ruby Is Cool

> p "Ruby Is Cool"
"Ruby Is Cool"

#pp
# like p, but it prints big hashes & arrays in a nicer way.
irb(main):008:0> pp [1,2]
[1, 2]
=> [1, 2]
## Input
