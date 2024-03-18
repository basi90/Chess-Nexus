class GamesController < ApplicationController
  def new
    @game = Game.create(white_id: current_user.id, black_id: User.find(41).id)
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
