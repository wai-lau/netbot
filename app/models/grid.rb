class Grid < ApplicationRecord
  belongs_to :game
  serialize :state

  def process_move(move, grid_state)
    if move.include?("refresh")
      return refresh grid_state
    elsif move.include? "load"
      return state
    elsif move == "blank10"
      return load_stage(:blank10)
    elsif move == "hack10"
      return load_stage(:hack10)
    end
    return nil
  end

  private

  def load_stage(stage_name=:blank10)
    StageLoader.load(stage_name)
  end

  def refresh(grid_state)
    grid_state
  end
end
