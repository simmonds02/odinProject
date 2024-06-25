require 'pry-byebug'
# binding.pry

def ceasar_cipher(text, key)
  charArray = text.split("")
  ## shift ascii by key
  charArray.map! do |char| 
    charAscii = char.ord.to_i
    if charAscii <= 122 && charAscii >=97
      # puts  "#{char} is lowercase"
      # add key to ascii
      charAscii += key
      # check key is within range
      # shift if not in range
      if charAscii >= 122 
        charAscii -= 26
      elsif charAscii <=97
        charAscii += 26
      end
    elsif charAscii <= 90 && charAscii >= 65
      # puts  "#{char} is uppercase"
        # puts  "#{char} is lowercase"
      # add key to ascii
      charAscii += key
      # check key is within range
      # shift if not in range
      if charAscii >= 90 
        charAscii -= 26
      elsif charAscii <= 65
        charAscii += 26
      end
    end
    charAscii
  end
  # map back to string
  charArray.map! { |char| char.chr}
  newstring = charArray.join
  puts newstring
end

ceasar_cipher("whatever happens, happens", 1)



=begin
  for lowercase range = 97 - 122
  for uppercase range = 65 - 90
  check for uppercase vs lowercase
=end
