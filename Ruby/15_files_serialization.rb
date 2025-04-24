## Thoughtbot
# IO in Ruby
# 
# Ruby IO objects wrap Input/Output streams. 
# The constants STDIN, STDOUT, and STDERR point to IO objects wrapping the standard streams. 
# By default the global variables $stdin, $stdout, and $stderr point to their respective constants. 
# While the constants should always point to the default streams, the globals can be overwritten to point to another I/O stream such as a file.
# IO objects can be written to via puts and print.

$stdout.puts 'Hello World'
puts 'Hello World'

[1] pry(main)> $stdin.puts 'foo'
IOError: not opened for writing
[2] pry(main)> $stdout.gets
IOError: not opened for reading
[3] pry(main)> $stderr.gets
IOError: not opened for reading

# create a new IO object
[1] pry(main)> io = IO.new(1)
=> #<IO:fd 1>
[2] pry(main)> io.puts 'hello world'
hello world
=> nil

[1] pry(main)> fd = IO.sysopen('/dev/null', 'w+')
=> 8
[2] pry(main)> dev_null = IO.new(fd)
=> #<IO:fd 8>
[3] pry(main)> dev_null.puts 'hello'
=> nil
[4] pry(main)> dev_null.gets
=> nil
[5] pry(main)> dev_null.close
=> nil

# position
[1] pry(main)> IO.sysopen '/Users/joelquenneville/Desktop/lorem.txt'
=> 8
[2] pry(main)> lorem = IO.new(8)
=> #<IO:fd 8>
[3] pry(main)> lorem.gets
=> "Lorem ipsum\n"
[4] pry(main)> lorem.pos
=> 12
[5] pry(main)> lorem.gets
=> "dolor\n"
[6] pry(main)> lorem.gets
=> "sit amet...\n"
[7] pry(main)> lorem.pos
=> 30
[8] pry(main)> lorem.gets
=> nil
[9] pry(main)> lorem.eof?
=> true
[10] pry(main)> lorem.rewind
=> 0
[11] pry(main)> lorem.pos
=> 0

## Serialization Formats

# YAML

name: "David"
height: 124
age: 28
children:
  "John":
    age: 1
    height: 10
  "Adam":
    age: 2
    height: 20
  "Robert":
    age: 3
    height: 30
traits:
  - smart
  - nice
  - caring

require 'yaml'

class Person
  attr_accessor :name, :age, :gender
  def initialize(name, age, gender)
    @name = name
    @age = age
    @gender = gender
  end
  def to_yaml
    YAML.dump ({
      :name => @name,
      :age => @age,
      :gender => @gender
    })
  end
  def self.from_yaml(string)
    data = YAML.load string
    p data
    self.new(data[:name], data[:age], data[:gender])
  end
end
p = Person.new "David", 28, "male"
p p.to_yaml
p = Person.from_yaml(p.to_yaml)
puts "Name #{p.name}"
puts "Age #{p.age}"
puts "Gender #{p.gender}"


# JSON

{
  "name": "David",
  "height": 124,
  "age": 28,
  "children": {"John": {"age": 1, "height": 10},
             "Adam": {"age": 2, "height": 20},
             "Robert": {"age": 3, "height": 30}},
  "traits": ["smart", "nice", "caring"]
}

require 'json'
class Person
  # ...
  def to_json
    JSON.dump ({
      :name => @name,
      :age => @age,
      :gender => @gender
    })
  end
  def self.from_json(string)
    data = JSON.load string
    self.new(data['name'], data['age'], data['gender'])
  end
  # ...
end


# MessagePack

require 'msgpack'
msg = {:height => 47, :width => 32, :depth => 16}.to_msgpack
#prints out mumbo-jumbo
p msg
obj = MessagePack.unpack(msg)
p obj

class Person
  # ...
  def to_msgpack
    MessagePack.dump ({
      :name => @name,
      :age => @age,
      :gender => @gender
    })
  end
  def self.from_msgpack(string)
    data = MessagePack.load string
    self.new(data['name'], data['age'], data['gender'])
  end
  # ...
end