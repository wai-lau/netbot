class Grid < ApplicationRecord
  belongs_to :game
  serialize :state

  def process_move(move, grid_state)
    case move
    when "load"
      return state
    when "nosec"
      return load_stage(:nosec)
    when "hack10"
      return load_stage(:hack10)
    end

    if grid_state
      grid_state[:mode] ||= :move
      case grid_state[:mode]
      when :move
        case move
        when *%w(h j k l a)
          program_execute_move(move, grid_state)
          if move == "a"
            grid_state[:mode] = :attack
          end
          return grid_state
        when *%w(n p)
          change_selected(move, grid_state)
          return grid_state
        end  
      when :attack
        case move
        when "a"
          grid_state[:mode] = :move
          Grid::StateUpdater.clear_highlight(grid_state[:tiles])
          return grid_state
        end
      end
    end
     
    return nil
  end

  private

  def program_execute_move(move, grid_state)
    grid_state[:programs][selected(grid_state)].move(move, grid_state[:mode], grid_state[:tiles])
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
