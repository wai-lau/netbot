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
    games = Game.where(user_id: current_user.id)
    if games.any?
      games.last
    else
      game = Game.new
      game.user = current_user
      game.save
    end
  end
  
  def create
  end
end
