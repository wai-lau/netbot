class MovesController < ApplicationController
  def create
    move = Move.new
    ActionCable.server.broadcast 'moves',
      move: "aylmao"
    head :ok
  end
end
