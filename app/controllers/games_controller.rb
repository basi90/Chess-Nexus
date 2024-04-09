class GamesController < ApplicationController
  before_action :set_game, only: [:show, :select_piece, :select_move]

  def new
    if Game.last.nil?
      @game = Game.new(white: current_user)
      @board = Board.new
      @board.game = @game
      @board.save
      @board.start
      @board.save

      @chatroom = Chatroom.new
      @chatroom.game = @game
    elsif Game.last.white == current_user && Game.last.black.nil?
      @game = Game.last
    elsif Game.last.black_id.nil?
      @game = Game.last
      @game.black = current_user
    else
      @game = Game.new(white: current_user)
      @board = Board.new
      @board.game = @game
      @board.save
      @board.start
      @board.save

      @chatroom = Chatroom.new
      @chatroom.game = @game
    end

    @game.save

    redirect_to game_path(@game)
  end

  def show
    if @game.black.present?
      GameChannel.broadcast_to(
        @game,
        @game.black.profile
      )
    end
    @opponent = @game.white == current_user ? @game.black : @game.white

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

    piece = @board.check_board[select_row][select_col]
    if piece.color == @board.next_to_move
      valid_moves = @board.check_board[select_row][select_col].valid_moves
      moves = {}
      valid_moves.each_with_index do |move, index|
        moves[index] = { row: move[0], col: move[1] }
      end
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

    BoardChannel.broadcast_to(
      @board,
      board_white: render_to_string(partial: "board", locals: { game: @game, board: @board }, formats: [ :html ] ),
      board_black: render_to_string(partial: "boardblack", locals: { game: @game, board: @board }, formats: [ :html ] ),
      user: current_user
    )
  end

  def finished

  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
