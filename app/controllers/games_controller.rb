class GamesController < ApplicationController
  def new
    # if Game.last.black = !nil

    @game = Game.new(white: current_user, black: User.find(41))

    if @game.save
      GameChannel.broadcast_to(
        @game,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    end
    
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
