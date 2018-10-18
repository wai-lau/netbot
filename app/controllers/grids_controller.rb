class GridsController < ApplicationController
  def move
    unless current_game
      redirect_to new_game_url
      return
    end
    
    move = params["move"]["content"]
    new_state = current_grid.process_move(move, session["grid_state"])
   
    data = {
      text: move.reverse,
      update: !new_state.nil?
    }
    
    if data[:update]
      session["grid_state"] = new_state
      data[:grid_state] = Grid::StateTranslator.export(session["grid_state"])
    end

    broadcast data   
  end

  private
  
  def broadcast(data)
    ActionCable.server.broadcast 'moves',
      data
    head :ok
  end
  
  def current_game
    if current_user
      current_user.games.last
    end
  end

  def current_grid
    unless current_game.grid
      grid = Grid.new(game: current_game, state: Grid::StageLoader.load(:blank10))
      grid.save
    end 
    current_game.grid
  end
end
