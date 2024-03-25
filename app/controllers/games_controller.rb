class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update_board]

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

    @board = Board.new
    @board.game = @game
    @board.save

    @game.save

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

    @message = Message.new
    @chatroom = @game.chatroom
    @chatroom.save
    raise
  end

  def update_board
    @board_data = JSON.parse(request.body.read)
    row = @board_data["row"].to_i
    col = @board_data["column"].to_i
    # binding.b
    render json: { body: @board_data }
  end

  def finished

  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
