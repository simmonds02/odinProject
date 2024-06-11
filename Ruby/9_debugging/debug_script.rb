# require 'pry-byebug'

def isogram?(string)
  original_length = string.length
  string_array = string.downcase.split

  # binding.pry
  debugger

  unique_length = string_array.uniq.length
  original_length == unique_length
end

isogram?("Odin")


def yell_greeting(string)
  name = string

  binding.pry

  name = name.upcase
  greeting = "WASSAP, #{name}!"
  puts greeting
end

# yell_greeting("bob")
