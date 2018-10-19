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
      
      def update(tiles, program, old_sectors)
        old_sectors.each do |row, col|
          tiles[row][col].clear
        end
        place_program(tiles, program)
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

      private
    end
  end
end
