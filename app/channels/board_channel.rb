class BoardChannel < ApplicationCable::Channel
  def subscribed
    board = Board.find(params[:id])
    stream_for board
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
