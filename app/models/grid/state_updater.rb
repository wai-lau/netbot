class Grid
  class StateUpdater < Grid
    class << self
      def update_all(tiles, programs)
        tiles.each do |row|
          row.each do |t|
            t.clear
          end
        end

        programs.each do |p|
          place_program(tiles, p)
        end
      end
      
      def update(tiles, program, old_sectors, programs=nil)
        old_sectors.each do |row, col|
          tiles[row][col].clear
        end
        if program.cur_size > 0
          place_program(tiles, program)
        else
          programs.delete(program) 
        end
      end

      def place_program(tiles, program)
        row, col = program.sector_list.first
        tiles[row][col].head = true
        program.sector_list.each do |coord|
          row, col = coord
          tiles[row][col].type = :program
          tiles[row][col].owner = program
        end
      end

      def highlight(tiles, state_tiles, selected_target=nil, target_color=nil)
        tiles.each do|row, col|
          begin
            if row >= 0 && col >= 0
              state_tiles[row][col].highlight = true
              if selected_target
                srow, scol = selected_target
                if srow == row && scol == col
                  state_tiles[row][col].highlight = :selected
                end
              end
            end
          rescue
          end
        end
      end

      def clear_highlight(state_tiles)
        state_tiles.each do |row|
          row.each do |t|
            t.highlight = false
          end
        end
      end

      private
    end
  end
end
