class UsersController < ApplicationController
  def new
  end
  
  def create
    @user = User.new
    @user.name = params["user"]["name"]
    if @user.save
      redirect_to new_game_url
      return
    else
      redirect_to new_user_url 
      return
    end
  end
end
