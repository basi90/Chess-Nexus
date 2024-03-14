class BoardsController < ApplicationController
  def new
    # if !Board.last.black_id
      # join Board.last
    #else
      #@board = Board.new(white_id: current_user)
    # end
  end

  def show
    @board = Board.find(params[:id])
  end
end
