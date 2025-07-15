require './hash_map/hash_maps.rb'

test = HashMap.new(0.75)

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts "--------------------"
puts "Length of HashMap = #{test.length}"

test.set('lion', 'scar')
test.set('apple', 'granny')
test.set('ice cream', 'strawberry')

puts "--------------------"
puts "Length of HashMap = #{test.length}"

test.set('moon', 'silver')

puts "Length of HashMap = #{test.length}"

puts test.buckets

test.set('elephant', 'asian')
test.set('frog', 'toxic')
test.set('grape', 'wine')

puts "Length of HashMap = #{test.length}"

puts test.buckets


#  puts "Length of HashMap = #{test.length}"

#  test.set('apple', 'red')
#  test.set('banana', 'yellow')
#  test.set('carrot', 'orange')
#  test.set('dog', 'brown')
#  test.set('elephant', 'gray')
#  test.set('frog', 'green')
#  test.set('grape', 'purple')
#  test.set('hat', 'black')
#  test.set('ice cream', 'white')
#  test.set('jacket', 'blue')
#  test.set('kite', 'pink')
#  test.set('lion', 'golden')
 test.set('jamal', 'abbott')
#  test.set('james', 'gamer')
#  test.set('jackson', 'goner')
 test.set('junky', 'mess')
#  test.set('jimmy', 'john')
#  test.set('jaquese', 'sings')


# puts test.buckets

# test.set('lion', 'gold')

# puts test.buckets

# puts test.get('apple')
# puts test.get('banana')
# puts test.get('carrot')
# puts test.get('dog')
# puts test.get('elephant')
# puts test.get('frog')
# puts test.get('grape')
# puts test.get('hat')
# puts test.get('ice cream')
puts test.get('jacket')
puts test.get('kite')
puts test.get('lion')
puts test.get('li')


puts test.has?('ice')
puts test.has?('ice cream')
puts test.has?('ce')



puts test.buckets

puts "Length of HashMap = #{test.length}"

puts test.remove('jamal')
puts test.remove('junky')
puts test.remove('elephant')
puts test.remove('ham')

puts test.buckets

puts "Length of HashMap = #{test.length}"

p test.keys
p test.values
p test.entries

puts test.clear

puts "Length of HashMap = #{test.length}"

p test.keys
p test.values
p test.entries