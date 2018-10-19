class UsersController < ApplicationController
  def new
    save
    reset_session
  end
  
  def create
    user = User.find_by(name: params["user"]["name"]) 
    unless user
      user = User.new
      user.name = params["user"]["name"]
      unless user.save
        redirect_to new_user_url
        return
      end 
    end
    
      session["user_id"] = user.id
      redirect_to new_game_url
    return
  end

  private 

  def save
    if current_user
      game = current_user.games.last if current_user.games
      if game
        game.save
        if game.grid
          if request.session["grid_state"]
            game.grid.state = request.session["grid_state"]
          end
          game.grid.save
        end
      end
    end
  end
end
