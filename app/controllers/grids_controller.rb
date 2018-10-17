class GridsController < ApplicationController
  def move
    unless current_game
      redirect_to new_game_url
      return
    end
    
    move = params["move"]["content"]
    
    initialize_grid unless current_grid_state

    data = {
      text: move.reverse,
    }

    session["grid_state"] = current_grid.process_move(move, session["grid_state"])
    data["update"] = true
    data["grid_state"] = current_grid_state

    broadcast data   
  end

  private
  
  def broadcast(data)
    ActionCable.server.broadcast 'moves',
      data
    head :ok
  end
  
  def initialize_grid
    game = current_game
    grid = Grid.new
    grid.game = game
    grid.state = blank10
    grid.save
  end

  def current_game
    if current_user && current_user.id
      if Game.find_by(user_id: current_user.id)
        Game.where(user_id: current_user.id).last
      end
    end
  end

  def current_grid
    initialize_grid unless current_game.grid
    current_game.grid
  end

  def current_grid_state
    session["grid_state"] ||= current_grid.state
  end

  def blank10
    [*0..9].map { |i| [*0..9].map { |j| "#{i} : #{j}" } }
  end
end
