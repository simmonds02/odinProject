# Build a tic-tac-toe game on the command line 
# where two human players can play against each other 
# and the board is displayed in between turns.
# 
# Think about how you would set up the different elements within the game… What should be a class? 
# Instance variable? Method? A few minutes of thought can save you from wasting an hour of coding.
# Build your game, taking care to not share information between classes any more than you have to.
# Post your solution below, then check out this example Tic Tac Toe solution from RosettaCode.org.
# 
# 1. Create a board class that will hold the state of the game
# 2. Create a player class that holds the state of a players moves
# 3.  
# 
# Classes - board
# Instances - boards
# Methods - take turn, start game, end game, display board, get player turn
# 

$turn = true


def start_new_game
    game_board = Array.new(9){|i| (i).to_s }
    display_board(game_board)

    while check_end_of_game(game_board) == false
        puts "Provide the number of the spot you would like to mark player #{$turn ? "x" : "y"}"
        input = gets.chomp.to_i
        mark_spot(game_board, input)
        display_board(game_board)
    end

    display_board(game_board)
    puts "Game Over"
end

def display_board(board)
    p board[0..2]
    p board[3..5]
    p board[6..8]
end

def mark_spot(board, spot)
    if ["x", "y"].include? board[spot]
        puts "Spot already chosen, please chose again"
        return
    end

    mark = $turn == true ? "x" : "y"
    puts "#{mark} set at spot #{spot}"
    board[spot] = mark

    change_turn
end

def change_turn
    $turn = !$turn    
end

def check_end_of_game(board)
    if (check_tie(board) || check_horizontals(board) || check_verticals(board) || check_diagonals(board))
        return true
    end
    return false
end

def check_horizontals(board)
    if (board[0..2].all?("x") || board[0..2].all?("x"))
        puts "Player #{board[0]} wins"
        return true
    elsif(board[3..5].all?("x") || board[3..5].all?("x"))
        puts "Player #{board[3]} wins"
        return true
    elsif(board[6..8].all?("x") || board[6..8].all?("x"))
        puts "Player #{board[6]} wins"
        return true
    end
end

def check_verticals(board)
    if ([board[0], board[3], board[6]].all?("x") || [board[0], board[3], board[6]].all?("y"))
        puts "Player #{board[0]} wins"
        return true
    elsif([board[1], board[4], board[7]].all?("x") || [board[1], board[4], board[7]].all?("y"))
        puts "Player #{board[1]} wins"
        return true
    elsif([board[2], board[5], board[8]].all?("x") || [board[2], board[5], board[8]].all?("y"))
        puts "Player #{board[2]} wins"
        return true
    end
end

def check_diagonals(board)
    if ([board[0], board[4], board[8]].all?("x") || [board[0], board[4], board[8]].all?("y"))
        puts "Player #{board[4]} wins"
        return true 
    elsif([board[2], board[4], board[6]].all?("x") || [board[2], board[4], board[6]].all?("y"))
        puts "Player #{board[4]} wins"
        return true 
    end
    return false
end

def check_tie(board)
    if board.all? { |x|  ["x", "y"].include?(x) }
        puts "Tie Game - everyone loses lol"
        return true 
    end
end


start_new_game