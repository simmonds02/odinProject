require './../../Ruby/Projects/tic_tac_toe.rb'


describe "#tic_tac_toe" do
  
  subject(:game_board) {Array.new(9){|i| (i).to_s }}
  subject(:start_game) {start_new_game}   
  subject(:display_game_board) {display_board(game_board)}
  subject(:mark_a_spot) {mark_spot(game_board, 8)}
  subject(:check_end_of_game) {check_end_of_game}
  subject(:change_player_turn) {change_turn}
  # subject(:start_game) {start_new_game}

  # context "when game is started" do
    # before do
    #     allow(check_end_of_game).to receive(:gets).and_return(0,3,1,4,2)
    #     allow(start_game).to receive(check_end_of_game)
    # end

    it "a board is displayed" do
      display_game_board
      expect(display_game_board).to eql(game_board[6..8])
    end

    it "a spot is marked" do
      # mark_a_spot
      expect(mark_a_spot).to receive(:change_player_turn)
    end

    # it "has the same length as input" do
    #   expect(cipher.length).to eq(text.length)
    # end

    # it "does not equal original text" do
    #   expect(cipher).not_to eq(text)
    # end

  # end


end