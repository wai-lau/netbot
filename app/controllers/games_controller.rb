class GamesController < ApplicationController
  def index
  end

  def show
    @move = Move.new
  end

  def new
  end
end
