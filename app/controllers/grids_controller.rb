class GridsController < ApplicationController
  def move
    broadcast (
      {
        text: params["move"]["content"].reverse
      }
    )
  end

  private
  
  def broadcast(data)
    ActionCable.server.broadcast 'moves',
      data
    head :ok
  end
end
