class GamesController < ApplicationController
  def new
    @game = Game.create(white: current_user, black: User.find(41))
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @chatroom = Chatroom.new
    @chatroom.game = @game
    @game.save
    @chatroom.save
  end
end
