class GameChannel < ApplicationCable::Channel
  def subscribed
    game = Game.find(params[:id])
    stream_from game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
