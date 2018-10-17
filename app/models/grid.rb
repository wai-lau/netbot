class Grid < ApplicationRecord
  belongs_to :game
  serialize :state

  def self.build_grid(game)
    grid = Grid.new
    grid.game = game
    grid.state = blank10
    game.save
  end

  def process_move(move, grid_state)
    if move.include?("shrink map")
      return shrink_map_ONLY_FOR_TESTING(grid_state)
    elsif move.include?("refresh")
      return refresh grid_state
    elsif move.include? "load"
      return state
    elsif move == "blank10"
      return blank10
    end
    return nil
  end

  def self.blank10
    [*0..9].map { |i| [*0..9].map { |j| "#{i} : #{j}" } }
  end

  private

  def blank10
    Grid.blank10
  end

  def refresh(grid_state)
    grid_state
  end

  def shrink_map_ONLY_FOR_TESTING(grid_state)
    grid_state.each do |row|
      row.pop
    end
  end
end
