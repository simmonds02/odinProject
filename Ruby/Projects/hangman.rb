# Introduction
# Files are a great way to save and reload a game, so we’ll give it a shot here by building Hangman.

# Assignment
# You will be building a command line Hangman game where one player plays against the computer, but a bit more advanced.
# 
# 8 Guesses allowed
# display blanks for word before game starts
# 
$guesses_allowed = 8

# Model
# 
## Sets up game by selecting hangman word
def setup_game
  word_array = Array.new()
  # import txt file
  fd = IO.sysopen('C:\Users\simmojx7\dev\odinProject\assets\google-10000-english-no-swears.txt')
  word_sheet = IO.new(fd)

  puts "------------"
  puts "WELCOME TO HANGMAN!"
  puts "------------"

  while !(word_sheet.eof?)
    word = word_sheet.gets.chomp.to_s
    word_length = word.length

    # filter and save words to array
    if word_length >= 5 && word_length <= 12
      word_array << word
    end
  end
  word_sheet.close

  # randomly select word between 5-12 characters
  $hangman_word = word_array[rand(word_array.length)]

  # puts "Your hangman word is #{$hangman_word}"
  $placeholder_word = "_" * $hangman_word.length
  puts "Your word is #{$placeholder_word.length.to_s} characters long"
end

# View
def display_game_status
  
  puts ""
  puts $placeholder_word

  if !($placeholder_word.include?("_"))
    puts "You win! Great Guessing"
    return true
  else
    return false
  end
    
end

# Controllers
def game_model
  setup_game
  display_game_status

  guess_counter = 0
  letters_guessed = Array.new()
  win_status = false 

  while (guess_counter < $guesses_allowed) && (win_status == false)
    puts "Please guess a letter: "
    new_guess = gets.chomp.to_s.downcase
    if (new_guess.length != 1)
      # let user know guess was multiple chars
      puts "Ensure your guess is one character... try again"
    elsif (letters_guessed.include?(new_guess))
      puts "You already guessed that... try again "
    else
      # add guess to array
      letters_guessed << new_guess
      # check guess against hangman word
      guess_results = $hangman_word.chars.map {| element | element == new_guess }
      if guess_results.all?(false)
        puts "Sorry that characters is not in the word"
        # increase guess counter since wrong
        guess_counter += 1
      else
        guess_results.each_with_index do | element , index |
          if element == true
            $placeholder_word[index] = new_guess      
          end
        end
      end
    end
    puts "So far you have guessed #{letters_guessed}"
    puts "You have #{($guesses_allowed-guess_counter)} guesses left"
    if guess_counter == $guesses_allowed
      puts "Game Over. You ran out of guesses. :("
    else 
      win_status = display_game_status
    end
  end
end

game_model