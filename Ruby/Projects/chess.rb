
# Ruby Chess Game Model-View-Controller (MVC) Structure
# Model
    # Stores data for each piece and  
    # Takes commands from controller
    # 
# View
    # Take in next action from Users
    # Display current status of Model on Chess board
    # Contains logic for determining valid moves 
    # Watches for changes in Model
# Controller
    # Directs commands to Model from view
    # Start game
    # 
class ChessPiece
       
    # Color
    # Type 
    # Name
    attr_reader :type, :color, :name, :id

    @@next_id = 0

    def initialize(type, color)
        @type = type
        @color = color  
        # Darren Says not to save all move options
        # @move_options = create_new_piece(type) 
        @name = ((@color[0]) + (name_selector)).upcase
        @@next_id += 1
        @id = (name.to_s + @@next_id.to_s)
    end

    def name_selector
        #case insensitive comparison
        if @type.casecmp("Knight") == 0 
            return @type[1]
        else
            return @type[0]
        end     
    end
end

class ChessModel
    attr_accessor :chess_board, :view
    def initialize(view)
        @view = view
        @chess_board = create_chess_board
        setup_chess_game
        view.update_state(@chess_board)
    end

    # initialize standard 8x8 chess board
    def create_chess_board
        board_array = Array.new(8){ |i| Array.new(8){|j|  "__" } }
        return board_array
    end


    def setup_chess_game
        chess_board.each_with_index do |row, i|
            row.each_with_index do |element, j|
                case [i, j]
                # when [1, j]
                #     chess_board[i][j] = ChessPiece.new("pawn", "black").name
                # when [6, j]
                #     chess_board[i][j] = ChessPiece.new("pawn", "white").name
                # when [0, 0], [0, 7]
                #     chess_board[i][j] = ChessPiece.new("rook", "black").name
                # when [7, 0], [7, 7]
                when [2, 6]
                    chess_board[i][j] = ChessPiece.new("rook", "white").name
                # when [0, 1], [0, 6]
                #     chess_board[i][j] = ChessPiece.new("knight", "black").name
                # when [7, 1], [7, 6]
                #     chess_board[i][j] = ChessPiece.new("knight", "white").name
                # when [0, 2], [0, 5]
                #     chess_board[i][j] = ChessPiece.new("bishop", "black").name
                # when [7, 2], [7, 5]
                #     chess_board[i][j] = ChessPiece.new("bishop", "white").name
                # when [0, 3]
                #     chess_board[i][j] = ChessPiece.new("queen", "black").name
                # when [7, 3]
                #     chess_board[i][j] = ChessPiece.new("queen", "white").name
                when [0, 7]
                    chess_board[i][j] = ChessPiece.new("king", "black").name
                when [2, 7]
                    chess_board[i][j] = ChessPiece.new("king", "white").name         
                end
            end
        end
    end

    def update_chess_board(piece_coor, destination_coor)
        piece_to_move = chess_board[piece_coor[0]][piece_coor[1]]
        puts piece_to_move
        # move piece to new spot
        chess_board[destination_coor[0]][destination_coor[1]] = piece_to_move
        # set old spot to empty
        chess_board[piece_coor[0]][piece_coor[1]] = "__"
        view.update_state(chess_board)
    end

end

class ChessView
    attr_accessor :controller, :who_turn, :black_in_check, :white_in_check, :black_king_moved, :white_king_moved, :black_rook_0_moved, :black_rook_7_moved, :white_rook_0_moved, :white_rook_7_moved, :castle_move
    def initialize
        @controller
        @who_turn
        @black_in_check = false
        @white_in_check = false
        @black_king_moved = true
        @white_king_moved = true
        @black_rook_0_moved = true
        @black_rook_7_moved = true
        @white_rook_0_moved = true
        @white_rook_7_moved = true
        @castle_move
    end

    def welcome_players
        puts "Welcome to Jamal's Chess Game via CL " 
    end

    def display_instructions
        puts "In this game you will provide the coordinates of the ..... more coming soon"
    end
    
    def change_turn
        if who_turn == nil
            @who_turn = controller.turn ? "W" : "B"   
        else       
            controller.turn = !controller.turn   
            @who_turn = controller.turn ? "W" : "B" 
        end
    end

    #take inputs from players
    def make_move(possible_moves_from_opponent)
        # Display whos turn it is
        puts "It is #{who_turn}'s turn, make sure to choose one of your pieces"

        # Get piece of interest
        piece_coor = nil
        destination_coor = nil
        possible_moves = []

        loop do
            puts "Where is the piece you want to move (row,col), e.g., 0,2: "
            piece_input = gets.chomp
            piece_coor = piece_input.split(',').map(&:to_i)
            if is_valid_piece?(piece_coor)
                # Generate all valid moves given piece and current board
                possible_moves += get_valid_moves(piece_coor, false, possible_moves_from_opponent)           
                break if !(possible_moves.empty?)
            end
        end

        orig_piece_name = controller.model.chess_board[piece_coor[0]][piece_coor[1]]
        

        # Get destination of interest
        loop do
            puts "Choose one of the valid destinations for this piece (row,col), e.g., 0,2: "
            destination_input = gets.chomp
            destination_coor = destination_input.split(',').map(&:to_i)
            destination_piece_name = controller.model.chess_board[destination_coor[0]][destination_coor[1]]

            if possible_moves.include?(destination_coor)
                if !((destination_piece_name.include?(orig_piece_name[0])) || (destination_piece_name.include?("__")))
                    puts "its an attack, take the opponents piece"
                end
                break  
            else 
                puts "That is not a valid move in the list, please choose a valid space from the list above"                      
            end



        end
        
        send_valid_move(piece_coor, destination_coor)
        change_turn
    end

    def start_game
        total_moves = 0  
    
        #set initial turn
        change_turn
        # Welcome & How To
        welcome_players
        display_instructions

        # looop for game runner
        loop do
            # check for check and check mate
            # if check move must be not in check
            possible_moves_from_opponent = check_for_check
            # get move
            # make move
            # check game state
            # change turn 
            
            make_move(possible_moves_from_opponent)
            can_claim_draw?(total_moves)    
            is_stalemate?(possible_moves)
        end
        # repeat

    end

    #determine if king, is in check
    def check_for_check(all_possible = false)
        x = 0
        y = 0
        possible_black_moves = []
        possible_white_moves = []
        for x in 0..7
            for y in 0..7
                # get all black pieces possible moves and if it equals kings position he is in check
                if is_valid_piece?([x,y], true)
                    piece_name = controller.model.chess_board[x][y]
                    if piece_name.include?("WK")
                        white_king_coor = [x,y]
                        possible_white_moves += get_valid_moves([x,y], false, possible_black_moves) if get_valid_moves([x,y]) 
                    elsif piece_name.include?("BK")
                        black_king_coor = [x,y]
                        possible_black_moves += get_valid_moves([x,y], false, possible_white_moves) if get_valid_moves([x,y]) 
                    elsif piece_name.include?("B") && get_valid_moves([x,y])
                        possible_black_moves += get_valid_moves([x,y], false, possible_white_moves)
                    elsif piece_name.include?("W") && get_valid_moves([x,y])
                        possible_white_moves += get_valid_moves([x,y], false, possible_black_moves)
                    end
                end
            end
        end

        if piece_name.include?("WK")
            white_king_coor = [x,y]
            possible_white_moves += get_valid_moves([x,y], false, possible_black_moves) if get_valid_moves([x,y]) 
        elsif piece_name.include?("BK")
            black_king_coor = [x,y]
            possible_black_moves += get_valid_moves([x,y], false, possible_white_moves) if get_valid_moves([x,y]) 

        possible_moves = possible_black_moves + possible_white_moves
        
        # Return true or False for given coordinates to check spaces around king
        if given_coor
        
        end

        if possible_black_moves.include?(white_king_coor)
            puts "White king in check"
            @white_in_check = true
            is_checkmate?(white_king_coor, possible_black_moves)
        elsif possible_white_moves.include?(black_king_coor)
            puts "black king in check"
            @black_in_check = true
            is_checkmate?(black_king_coor, possible_white_moves)
        else
            puts "Weeee gooooooood" 
            @white_in_check = false
            @black_in_check = false
        end
        p "all possible moves #{possible_moves}"
        p "all possible black moves #{possible_black_moves}"
        p "all possible white moves #{possible_white_moves}"
        puts ""
        return possible_moves if (all_possible == true)
        return possible_black_moves if (who_turn == "W")
        return possible_white_moves if (who_turn == "B")
    end 

    def can_claim_draw?(total_moves)
        if total_moves >= 50
            return true  
        else
            total_moves += 1 
            return false
        end
    end

    def is_stalemate?
        # are there possible moves
        possible_moves = check_for_check(true)
        if ( (possible_moves.empty?) && !(@white_in_check) && !(@black_in_check) )
            puts "Stalemate, no moves for anyone"
        end
          
    end

    def is_checkmate?(king_coor, possible_moves)
        # can king move
        kings_moves = get_valid_moves(king_coor, true)
        # remove moves that result in king still being in check
        kings_moves.delete_if{ |x| possible_moves.include?(x) }
        # can the piece applying check, be taken
        # can a piece be moved between the king and attacker   
          
    end
    
    def is_castle_allowed(piece_coor, possible_moves_from_opponent)
        puts "castle ran"
        left_moves = []  
        right_moves = []  
        final_moves = []  
        row_to_check = (who_turn == "W") ? 7 : 0
        chess_board = controller.model.chess_board
        piece_name = chess_board[piece_coor[0]][piece_coor[1]]
        # check if king is in check
        return false if (black_in_check && (who_turn == "B"))
        return false if (white_in_check && (who_turn == "W"))
        # puts "castle check check ran"
        # check have king and or either rook moved
        return false if (black_king_moved && (who_turn == "B"))
        return false if (white_king_moved && (who_turn == "W"))
        # Check for rook movement
        return false if (black_rook_0_moved && (who_turn == "B"))
        return false if (black_rook_7_moved && (who_turn == "B"))
        return false if (white_rook_0_moved && (who_turn == "W"))
        return false if (white_rook_7_moved && (who_turn == "W"))
        # puts "castle king moved ran"
        
        # check if spaces between king and rook are empty
        # check if spaces between king and rook can be attacked
        for y in 1..3
            return false if possible_moves_from_opponent.include?(chess_board[row_to_check][y])
            if ((chess_board[row_to_check][y] == "__") && (piece_name.include?("K")))
                left_moves += ["left"] 
                # not sure if I should generate moves here or in get valid moves based on returns from this 
            else
                left_moves += [false]
            end
        end
        
        for z in 5..6
            return false if possible_moves_from_opponent.include?(chess_board[row_to_check][z])
            if ((chess_board[row_to_check][z] == "__") && (piece_name.include?("K")))
                right_moves += ["right"] 
            else
                right_moves += [false]
            end
        end
        
        # puts "#{left_moves + right_moves} in castle moves"
        
        final_moves += ["left"] if ((left_moves.count("left") == 3) && !(left_moves.include?(false)))
        final_moves += ["right"] if ((right_moves.count("right") == 2) && !(right_moves.include?(false)))
        
        puts "#{final_moves} in final moves"
        return final_moves
    end

    def piece_name(piece_coor)
        return piece_name = controller.model.chess_board[piece_coor[0]][piece_coor[1]]
    end

    def check_for_castle(piece_coor, possible_moves_from_opponent)
        castle_moves = is_castle_allowed(piece_coor, possible_moves_from_opponent)
        castle_row = piece_name(piece_coor).include?("W") ? 7 : 0
        add_these_moves = []

        if castle_moves
            for x in castle_moves
                if ((x == "left") && piece_name(piece_coor).include?("K"))
                    add_these_moves << [castle_row , 2]
                elsif ((x == "right") && piece_name(piece_coor).include?("K"))
                    add_these_moves << [castle_row , 6]
                end
            end
            add_these_moves.uniq!
            castle_moves(add_these_moves) if add_these_moves
        end
        return add_these_moves
    end
    
    #determine if pawn has viable attacks
    def get_pawn_attacks(piece_coor)
        # needs up and down option for rooks, queens, kings
        piece_name = controller.model.chess_board[piece_coor[0]][piece_coor[1]]
        b_pawn_attacks = [1, 1], [1, -1]
        w_pawn_attacks = [-1, 1], [-1, -1]
        attacks = piece_name.include?("W") ? w_pawn_attacks : b_pawn_attacks
        attacks.map!{ |x,y| [(x + piece_coor[0]),(y + piece_coor[1])]}
        attacks.filter!{|x,y| ((x <= 7) && (x >= 0)) && ((y <= 7) && (y >= 0))}
        attacks.filter!{|x,y| !(controller.model.chess_board[x][y].include?("__") || controller.model.chess_board[x][y].include?(piece_name[0]))}
        # puts "Pawn #{piece_name} Attacks = #{attacks}"
        return attacks
    end

    #determine if move is allowed for pawn, queen, king, rook
    def get_vertical(piece_coor, y = "up")
        # needs up and down option for rooks, queens, kings
        piece_name = controller.model.chess_board[piece_coor[0]][piece_coor[1]]  
        moves = []
        row = piece_coor[0]
        col = piece_coor[1]
        vert_move = 0
        count = 0
        desired_count = 0
        case piece_name
            when "WP", "BP"
                # get white pawn that hasn't moved
                if (((piece_name.include?("W")) && (piece_coor[0] == 6)) || ((piece_name.include?("B")) && (piece_coor[0] == 1)))
                    desired_count = 2
                else
                    desired_count = 1
                end
                vert_move = piece_name.include?("W") ? -1 : 1
            when "WK", "BK"
                desired_count = 1
                vert_move = y.include?("up") ? -1 : 1
            when "WQ", "BQ", "WR", "BR"
                desired_count = 8
                vert_move = y.include?("up") ? -1 : 1
        end
        temp_row = row + vert_move
        while ((temp_row >= 0) && (temp_row <= 7) && (count < desired_count))
            if controller.model.chess_board[temp_row][col] == "__"
                p [ temp_row , col ]
                moves << [ temp_row , col ]
            elsif !((controller.model.chess_board[temp_row][col].include?(piece_name[0])) || (piece_name.include?("P")))
                p [ temp_row , col ]
                moves << [ temp_row , col ]
                break
            else
                break
            end
            temp_row += vert_move
            count += 1
        end
        return moves
    end

    def get_horizontal(piece_coor , x = "right")
        piece_name = controller.model.chess_board[piece_coor[0]][piece_coor[1]]  
        moves = []
        row = piece_coor[0]
        col = piece_coor[1]
        horizon_move = x == "left" ? -1 : 1
        temp_col = col + horizon_move
        count = 0
        desired_count = 0
        case piece_name
            when "WK", "BK"
                desired_count = 1
            when "WQ", "BQ", "WR", "BR"
                desired_count = 8
        end
        while ((temp_col >= 0) && (temp_col <= 7) && (count < desired_count))
            if controller.model.chess_board[row][temp_col] == "__"
                p [ row , temp_col ]
                moves << [ row , temp_col ]
            elsif !controller.model.chess_board[row][temp_col].include?(piece_name[0])
                p [ row , temp_col ]
                moves << [ row , temp_col ]
                break
            else
                break
            end
            temp_col += horizon_move
            count += 1
        end
        return moves
    end

    #determine if move is allowed for queen, king, bishop
    def get_diagonal(piece_coor, x = "left", y = "down")
        piece_name = controller.model.chess_board[piece_coor[0]][piece_coor[1]]  
        moves = []
        row = piece_coor[0]
        col = piece_coor[1]
        
        col_move = (x == "left") ? -1 : 1
        row_move = (y == "down") ? -1 : 1
        
        temp_col = col + col_move
        temp_row = row + row_move

        count = 0
        desired_count = 0
        case piece_name
            when "WK", "BK", "WP", "BP"
                desired_count = 1
            when "WQ", "BQ", "WB", "BB"
                desired_count = 8
        end

        while ((temp_col <= 7) && (temp_col >= 0) && (temp_row <= 7) && (temp_row >= 0) && (count < desired_count))
                            
            if controller.model.chess_board[temp_row][temp_col] == "__"
                p [ temp_row , temp_col ]
                moves << [ temp_row , temp_col ]
            elsif !controller.model.chess_board[temp_row][temp_col].include?(piece_name[0])
                p [ temp_row , temp_col ]
                moves << [ temp_row , temp_col ]
                break
            else
                break
            end
            temp_col += col_move
            temp_row += row_move
            count += 1
        end
        return moves
    end

    #determine if piece of interest is valid
    def is_valid_piece?(coor, check = false)
        # Check coordinates are on board (0 < x < 7)
        if ( (coor[0] > 7) || (coor[0] < 0) || (coor[1] > 7) || (coor[1] < 0))
            puts "Coordinates are not on board, try again"
            return false 
        end

        piece_name = controller.model.chess_board[coor[0]][coor[1]]
        if (piece_name.include?("__"))
            puts "Empty space choosen, try again"
            return false
        elsif (piece_name.include?(who_turn) || check)
            puts "Valid Piece: #{piece_name} picked"
            return true
        else
            puts "Invalid Piece: #{piece_name} belongs to the opponent, try again"
            return false
        end
    end

    #determine what moves are allowed given a choose of piece
    # changes, instead of getting all avaliable moves we should validate all moves before adding rather than remove after the fact
    # reuse invalid moves to be used in each get moves case
    def get_valid_moves(piece_coor, check = false, possible_moves_from_opponent = [])
        valid_moves = []
        piece_name = controller.model.chess_board[piece_coor[0]][piece_coor[1]]
        case piece_name
        when "WP", "BP"
            valid_moves = get_vertical(piece_coor)
            # add attacking moves for diagonal if piece in spot 
            valid_moves += get_pawn_attacks(piece_coor)
        when "WN", "BN"
            # get possible moves for knight 
            # total of 8 possible moves every time 
            # checking as I add
            # knight moves = [+2, +1], [+2, -1], [+1, +2], [+1, -2], [-1, +2], [-1, -2], [-2, +1], [-2, -1]
            knight_moves = [2, 1], [2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]
            knight_moves.each do |x,y|
                p [x,y]
                if (((x + piece_coor[0]) <= 7) && ((x + piece_coor[0]) >= 0)) && (((y + piece_coor[1]) <= 7) && ((y + piece_coor[1]) >= 0))
                    if !(controller.model.chess_board[(x + piece_coor[0])][(y + piece_coor[1])].include?(piece_name[0]))
                        valid_moves << [(x + piece_coor[0]),(y + piece_coor[1])] 
                    end          
                end    
            end  
        when "WQ", "BQ", "WK", "BK"
            valid_moves = get_diagonal(piece_coor, "left", "up")
            valid_moves += get_diagonal(piece_coor, "left", "down")
            valid_moves += get_diagonal(piece_coor, "right", "down")
            valid_moves += get_diagonal(piece_coor, "right", "up")
            valid_moves += get_horizontal(piece_coor, "left")
            valid_moves += get_horizontal(piece_coor, "right")
            valid_moves += get_vertical(piece_coor, "up")
            valid_moves += get_vertical(piece_coor, "down")
            valid_moves += check_for_castle(piece_coor, possible_moves_from_opponent)
            # remove king moves if moving into danger
            removed_moves = valid_moves.delete_if{ |x| possible_moves_from_opponent.include?(x) }
            puts "King Moves #{removed_moves}"
            puts "Opponent Moves #{possible_moves_from_opponent}"

        when "WB", "BB"
            valid_moves = get_diagonal(piece_coor, "left", "up")
            valid_moves += get_diagonal(piece_coor, "left", "down")
            valid_moves += get_diagonal(piece_coor, "right", "down")
            valid_moves += get_diagonal(piece_coor, "right", "up")
        when "WR", "BR"
            valid_moves = get_vertical(piece_coor, "up")
            valid_moves += get_vertical(piece_coor, "down")
            valid_moves += get_horizontal(piece_coor, "left")
            valid_moves += get_horizontal(piece_coor, "right")
        else
            puts "Invalid Piece Given, please check that you have chosen a valid piece"
        end

        if valid_moves.length > 0
            puts "Here are all valid moves for that piece, please choose one"
            p valid_moves
            return valid_moves
        else
            puts "No valid moves for that piece, please choose a different piece"
        end
    end

    def castle_moves(valid_castle_moves = [], clear = false)
        if valid_castle_moves.length > 0
            @castle_move = valid_castle_moves
        elsif clear == true
            @castle_move = []
        else
            return @castle_move
        end
    end

    #send valid to controller to be saved in model
    def send_valid_move(piece_coor, destination_coor)
        piece_name = controller.model.chess_board[piece_coor[0]][piece_coor[1]]
        puts "#{piece_name} is moving"
        case piece_name
            when "WK"
                puts "White King Moved"
                @white_king_moved = true
                if ((piece_coor[0] - destination_coor[0]).abs >= 2) || ((piece_coor[1] - destination_coor[1]).abs >= 2) 
                    puts "King is castling"
                    # move rook accordingly
                    if destination_coor[1] == 2
                        # move rook to 3
                        send_valid_move([7,0], [7,3])
                    elsif destination_coor[1] == 6
                        # move rook to 5
                        send_valid_move([7,7], [7,5])
                    end    
                end
            when "BK"
                puts "Black King Moved"
                @black_king_moved = true
            when "WR"
                puts "a White Rook Moved"
                if piece_coor[1] == 7
                    @white_rook_7_moved = true                      
                elsif piece_coor[1] == 0
                    @white_rook_0_moved = true                      
                end
            when "BR"
                puts "a Black Rook Moved"
                if piece_coor[1] == 7
                    @black_rook_7_moved = true                      
                elsif piece_coor[1] == 0
                    @black_rook_0_moved = true                      
                end
            end
        controller.send_move_to_model(piece_coor, destination_coor)
    end

    # print chess board to screen
    def display_chess_board(chess_board)
        for i in chess_board do
            puts i.join(" ")
        end
    end

    #update view    
    def update_state(new_state)
        display_chess_board(new_state)
    end
end

class ChessController
    attr_accessor :model, :turn, :turn_bool
    def initialize(model)
        @model = model
        @turn = true

    end

    #take inputs from players
    #determine if move is allowed
    #send valid moves to model to update data
    #once model is updated, request view to update
    #update view to match model   
    #display view after all changes
    #change players turn, request next move
    
    # setup controller to call all steps of game
    
    def send_move_to_model(piece_coor, destination_coor)
        model.update_chess_board(piece_coor, destination_coor)
    end


     

    # # track turn of black or white
    # @turn = true ? 'W' : 'B'
    # @turn = 'W'

end

#setup MVC
view = ChessView.new
model = ChessModel.new(view)
controller = ChessController.new(model)
view.controller = controller

view.start_game
