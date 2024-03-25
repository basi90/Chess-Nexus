class BoardsController < ApplicationController

  before_action :set_game_and_board, only: [:move, :check_game_status]

  def move
    from = params[:from].split(",").map(&:to_i)
    to = params[:to].split(",").map(&:to_i)

    begin
      @board.move_piece(from, to)
      @board.save
      flash[:notice] = "Move successful"
    rescue => e
      flash[:alert] = e.message
    end
    redirect_to game_path(@game)
  end

  def check_game_status
    if @board.checkmate?(:white)
      @game.update(status: "black_wins")
      flash[:notice] = "Checkmate! Black wins."
    elsif @board.checkmate?(:black)
      @game.update(status: "white_wins")
      flash[:notice] = "Checkmate! White wins."
    elsif @board.stalemate?(:white) || @board.stalemate?(:black)
      @game.update(status: "stalemate")
      flash[:notice] = "Stalemate! The game is a draw."
    elsif @board.draw_insufficient_material? || @board.draw_threefold_repetition?
      @game.update(status: "draw")
      flash[:notice] = "Draw! Insufficient material or threefold repetition."
    else
      if @board.king_in_check?(@board.next_to_move)
        flash[:alert] = "Check! Your king is in danger."
      end
    end

    redirect_to game_path(@game)
  end

  # def update_board

  #   html = render_to_string(partial: "path/to/chessboard_partial", locals: { board: @board }, formats: [:html])

  #   render json: { html: html }
  # end




  private

  def set_game_and_board
    @game = Game.find(params[:id])
    @board = @game.board
  end


  def board_params
    params.require(:board).permit(:game_id, :other_params)
  end
end
