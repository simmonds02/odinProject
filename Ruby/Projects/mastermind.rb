# Introduction
# If you’ve never played Mastermind, it’s a game where you have to guess your opponent’s secret code 
# within a certain number of turns (like hangman with colored pegs). 
# Each turn you get some feedback about how good your guess was – whether it was exactly correct 
# or just the correct color but in the wrong space.

# Assignment
# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, 
# starting with you guessing the computer’s random code.
# 

# Setup loop for 12 guesses

$colors_array = ["red", "blue", "green", "pink", "white", "orange", "yellow", "purple"]

def set_code
  code_array = Array.new()
  puts "You can choose any of these 8 colors: red, blue, green, pink, white, orange, yellow, purple"
  puts "Player 1"
  puts "Please enter 4 colors in sequence to create a code: "

  code_getter(code_array)

  return code_array
end


def run_game(code)
  puts ""
  puts "Player 2"
  guess_counter = 1
  $guess_correct = false
  while guess_counter <= 12 && $guess_correct == false
    guess_array = Array.new()
    puts "enter a pattern for guess # #{guess_counter}:"
    code_getter(guess_array)
    guess_counter += 1
    compare_code_guess(code, guess_array)
  end
  if $guess_correct == true
    puts "Good Guessing, You Won!!"
  else
    puts "Sorry you've exceeded the maximum number of guesses"
    puts "Better Luck Next Time"
  end
end

def compare_code_guess(code, guess)
    feedback_arr = Array.new()
    # check if guess is in code per item
    guess.each_with_index do |g, i|
      if code.include?(g)        
        # puts "#{g} is in code"
        match_arr = code.each_index.select {|c| code[i] == g}
        # puts match_arr
        if match_arr.include?(i)
          feedback_arr << "W"
        else
          feedback_arr << "R" 
        end
      end    
    end
    if feedback_arr.empty?
      puts "No matches"
    else 
      puts "Good Try: W=Match, R=In Array but Wrong index"
      p feedback_arr
    end
    puts ""
    if feedback_arr == ["W","W","W","W"]
      $guess_correct = true
    end
end

def code_getter(array)
  4.times do |x|
    check = true
    while check == true
      puts "Please enter color number #{x+1}"
      input = gets.chomp.to_s
      if $colors_array.include?(input)
        array << input  
        check = false
      else
        puts "Please enter a valid color..."
      end
    end
  end
end

code = set_code
run_game(code)