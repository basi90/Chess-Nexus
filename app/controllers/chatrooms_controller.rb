class ChatroomsController < ApplicationController
  def show
    @game = Game.find(params[:game_id])
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
