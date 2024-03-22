class BoardsController < ApplicationController
  def new
  end

  def show
    @board = Board.find(params[:id])
  end
end
