class GamesController < ApplicationController
  def index
  end

  def show
  end

  def new
    games = Game.where(user_id: current_user.id)
    game = games.last if games

    if game
      session["grid_state"] = game.state
    else
      game = Game.new
      game.user = current_user
      blank_10x10 = [*0..9].map { |i| [*0..9].map { |j| "#{i}:#{j}" } }
      session["grid_state"] = blank_10x10
      game.state = session["grid_state"]
      game.save
    end
  end

  def create
  end

  private

  def current_user
    if session["user_id"]
      User.find_by(id: session["user_id"])
    end
  end
end
