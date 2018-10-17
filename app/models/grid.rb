class Grid < ApplicationRecord
  belongs_to :game
  serialize :state

  def process_move(move, grid_state)
    if move.include?("shrink map")
      return shrink_map_ONLY_FOR_TESTING(grid_state)
    end
    grid_state
  end

  def shrink_map_ONLY_FOR_TESTING(grid_state)
    grid_state.each do |row|
      row.pop
    end
  end
end
