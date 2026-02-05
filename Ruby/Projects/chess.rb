
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
    attr_reader :type, :color, :name

    def initialize(type, color)
        @type = type
        @color = color  
        # Darren Says not to save all move options
        # @move_options = create_new_piece(type) 
        @name = ((@color[0]) + (name_selector)).upcase
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
        # return Array.new(8){|i| Array.new(8){|j| [ (i), (j) ]}}
        board_array = Array.new(8){ |i| Array.new(8){|j|  "__" } }
        # board_array.unshift(Array.new(8){|k|  " _" })
        return board_array
    end


    def setup_chess_game
        chess_board.each_with_index do |row, i|
            row.each_with_index do |element, j|
                case [i, j]
                when [1, j]
                    temp_piece = ChessPiece.new("pawn", "black")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [6, j]
                    temp_piece = ChessPiece.new("pawn", "white")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [0, 0], [0, 7]
                    temp_piece = ChessPiece.new("rook", "black")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [7, 0], [7, 7]
                    temp_piece = ChessPiece.new("rook", "white")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [0, 1], [0, 6]
                    temp_piece = ChessPiece.new("knight", "black")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [7, 1], [7, 6]
                    temp_piece = ChessPiece.new("knight", "white")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [0, 2], [0, 5]
                    temp_piece = ChessPiece.new("bishop", "black")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [7, 2], [7, 5]
                    temp_piece = ChessPiece.new("bishop", "white")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [0, 3]
                    temp_piece = ChessPiece.new("queen", "black")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [7, 3]
                    temp_piece = ChessPiece.new("queen", "white")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [0, 4]
                    temp_piece = ChessPiece.new("king", "black")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                when [7, 4]
                    temp_piece = ChessPiece.new("king", "white")
                    chess_board[i][j] = element.sub("__",temp_piece.name)
                end
            end
        end
    end

end

class ChessView
    attr_accessor :controller
    def initialize
        @controller
    end
    
    #send new view to controller to be displayed 
    

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
    attr_accessor :model
    def initialize(model)
        @model = model
    end

    #take inputs from players
    #determine if move is allowed
    #send valid moves to model to update data
    #once model is updated, request view to update
    #update view to match model   
    #display view after all changes
    #change players turn, request next move
     

    # track turn of black or white
    @turn = true ? 'White' : "Black"

end

view = ChessView.new
model = ChessModel.new(view)
controller = ChessController.new(model)
view.controller = controller

