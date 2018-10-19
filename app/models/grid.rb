class Grid < ApplicationRecord
  belongs_to :game
  serialize :state

  def process_move(move, grid_state)
    case move
    when "refresh"
      return refresh grid_state
    when "load"
      return state
    when "blank10"
      return load_stage(:nosec)
    when "hack10"
      return load_stage(:hack10)
    end

    if grid_state
      if %w(h j k l).include? move
        program_move(move, grid_state)
        return grid_state
      elsif %w(n p).include? move
        change_selected(move, grid_state)
        return grid_state
      end  
    end
     
    return nil
  end

  private

  def program_move(move, grid_state)
    grid_state[:programs][selected(grid_state)].move(move, grid_state[:tiles])
    StateUpdater.update_all(grid_state[:tiles], grid_state[:programs])
  end

  def selected(grid_state)
    grid_state[:selected_program] ||= 0
  end

  def change_selected(np, grid_state)
    return nil unless grid_state[:programs]
    case np
    when "n"
      grid_state[:selected_program] += 1
    when "p"
      grid_state[:selected_program] -= 1
    end
    grid_state[:selected_program] %= grid_state[:programs].length 
  end

  def load_stage(stage_name=:blank10)
    StageLoader.load(stage_name)
  end

  def refresh(grid_state)
    grid_state
  end
end
