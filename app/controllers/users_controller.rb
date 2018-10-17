class UsersController < ApplicationController
  def new
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
end
