# Project Management

require 'colorize'

puts 'Red goes faster!'.colorize(:red)

puts "I'm blue da ba dee da ba di!".colorize(:blue)

puts "It ain't easy bein' green...".colorize(:green)

## Require_Relative
# You're in the root of the project, the directory that holds main.rb

# main.rb
require_relative 'lib/sort'

# sort.rb
require_relative 'sort/bubble_sort'
require_relative 'sort/bogo_sort'
require_relative 'sort/merge_sort'


## Require
# You're in the root of the project, the directory that holds main.rb

# main.rb
require './lib/sort'

# sort.rb
require './sort/bubble_sort'
require './sort/bogo_sort'
require './sort/merge_sort'


## File Structure
### Classes - one per file
# You're in the root of the project, the directory that holds main.rb

# This is your file structure:
├── lib
│    ├── flight.rb
│    ├── hotel.rb
│    └── airport.rb
└── main.rb

# lib/airport.rb
class Airport
  def introduce
    puts "I'm at the airport!"
  end
end

# lib/flight.rb
class Flight
  def introduce
    puts "I'm on the flight!"
  end
end

# lib/hotel.rb
class Hotel
  def introduce
    puts "I'm at the hotel!"
  end
end

# main.rb
require_relative 'lib/airport'
require_relative 'lib/flight'
require_relative 'lib/hotel'

Airport.new.introduce
#=> I'm at the airport!

Flight.new.introduce
#=> I'm on the flight!

Hotel.new.introduce
#=> I'm at the hotel!


### Modules - wrap code in modules to reduce confusion
# all files are in the same directory for simplicity's sake

# not_so_green.rb
module NotSoGreen
  def self.food_opinion(food)
    `#{food} is awesome!`
  end
end

# scheals.rb
module Scheals
  def self.food_opinion(food)
    `#{food} is awful!`
  end
end
# main.rb
require_relative 'not_so_green'
require_relative 'scheals'

puts NotSoGreen.food_opinion('Cereal')
#=> Cereal is awesome!
puts Scheals.food_opinion('Marmite')
#=> Marmite is awful!
puts food_opinion('Cereal')
#=> Errors out - there's no longer a free floating food_opinion method to use.


## Gems
