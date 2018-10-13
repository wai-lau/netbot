class UsersController < ApplicationController
  def new
  end
  
  def create
    user = User.new
    user.name = params["user"]["name"]
    game = Game.create

    if user.save
      game.user = user
    end

    if game.save
      session["user_id"] = user.id
      redirect_to new_game_url
      return
    else
      redirect_to new_user_url 
      return
    end
  end
end
