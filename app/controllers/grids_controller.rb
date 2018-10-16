class GridsController < ApplicationController
  def move
    move = params["move"]["content"]
    broadcast (
      {
        text: move.reverse,
        update: move.include?("update"),
        grid_state: [*0..9].map { |i| [*0..9].map { |j| "#{i} : #{j}" } }
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
