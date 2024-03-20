class GamesController < ApplicationController
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

    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])

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
  end
end
