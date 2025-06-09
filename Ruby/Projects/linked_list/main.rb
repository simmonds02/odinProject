require './linked_list.rb'

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')


puts list

puts list.size

puts list.head

puts list.tail

puts list.at(0)

puts list.at(5)

puts list.contains?('dog')

puts list.contains?('turtle')

puts list.pop

puts list.size

puts list.contains?('snake')

puts list.contains?('turtle')

puts list.find('dog')

puts list.find('parrot')

puts list.find('snake')

puts list.find('turtle')

puts list

list.insert_at("noew guy", 2)

puts list

list.remove_at(2)

puts list