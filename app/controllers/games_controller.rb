class GamesController < ApplicationController
  before_action :set_game, only: [:show, :select_piece, :select_move]

  def new
    if Game.last.nil?
      @game = Game.new(white: current_user)
    elsif Game.last.black_id.nil?
      @game = Game.last
      @game.black = current_user
    else
      @game = Game.new(white: current_user)
    end

    @chatroom = Chatroom.new
    @chatroom.game = @game

    @game.save

    @board = Board.new
    @board.game = @game
    # binding.b
    @board.save
    @board.start
    @board.save

    redirect_to game_path(@game)
  end

  def show
    if @game.black.present?
      @opponent = @game.white == current_user ? @game.black : @game.white
      GameChannel.broadcast_to(
        @game,
        @game.black.profile.username
      )
    end

    @board = @game.board

    @message = Message.new
    @chatroom = @game.chatroom
    @chatroom.save
  end

  def select_piece
    @board = @game.board

    @board_data = JSON.parse(request.body.read)

    select_row = @board_data["row"].to_i
    select_col = @board_data["col"].to_i

    session[:current_piece] = [select_row, select_col]

    valid_moves = @board.check_board[select_row][select_col].valid_moves

    moves = {}
    valid_moves.each_with_index do |move, index|
      moves[index] = { row: move[0], col: move[1] }
    end

    render json: { body: moves }
  end

  def select_move
    @board = @game.board

    @board_data = JSON.parse(request.body.read)
    session[:current_piece]

    move_row = @board_data["row"].to_i
    move_col = @board_data["col"].to_i

    @board.move_piece(session[:current_piece], [move_row, move_col])
    # render json: { success: true, board_state: @board.board_state}
    # session[:board_state] = @board.board_state

  end

  def finished

  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
