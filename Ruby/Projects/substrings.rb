#   Implement a method #substrings that takes a word as the first argument and then an array of valid substrings
#    (your dictionary) as the second argument.
#   It should return a hash listing each substring (case insensitive)
#    that was found in the original string and how many times it was found.

def substrings(wordInput, dict)
  stor = Hash.new(0)
  wordInput.downcase!
  arrOfInput = wordInput.split(' ')
  # puts arrOfInput
  dict.each do |sub|
    arrOfInput.each do |word|
      stor[sub] += 1 if word.include?(sub)
    end
  end
  puts stor
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

substrings('low down below', dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)

#  > substrings("Howdy partner, sit down! How's it going?", dictionary)
#=> { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
