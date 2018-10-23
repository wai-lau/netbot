class GamesController < ApplicationController
  def index
  end

  def show
  end

  def new
    unless current_user && current_user.id
      redirect_to new_user_url
      return
    end
    unless current_game
      game = Game.new(user: current_user)
      game.save
    end
  end
  
  def move
    unless current_game
      redirect_to new_game_url
      return
    end
    
    move = params["move"]["content"]
    new_state = current_grid.process_move(move, session["grid_state"])
   
    data = {
      update: !new_state.nil?
    }
   
    if data[:update]
      session["grid_state"] = new_state
      data[:grid_state] = Grid::StateShrinker.shrink(session["grid_state"])
    else
      data[:text] = "NOP: #{move}"
    end

    broadcast data   
  end

  def create
  end

  private

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

  def broadcast(data)
    ActionCable.server.broadcast 'moves',
      data
    head :ok
  end
  
 
end
