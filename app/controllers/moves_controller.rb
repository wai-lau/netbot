class MovesController < ApplicationController
  def create
    move = params["move"]["content"]
    ActionCable.server.broadcast 'moves',
      move: move.reverse
    head :ok
  end
end
