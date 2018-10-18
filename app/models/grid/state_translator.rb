class Grid
  class StateTranslator < Grid
    class << self
      def export(state)
        tiles = state[:tiles]
        programs = state[:programs]

        paint_tiles(tiles)
        paint_programs(programs, tiles) unless programs.nil?

        tiles
      end

      private

      def paint_tiles(tiles)
        tiles.each do |row|
          row.each do |tile|
            tile.color = "white"
          end
        end
      end

      def paint_programs(programs, tiles)
        programs.each do |p|
          p.sector_list.each do |coord|
            row, col = coord
            tiles[row][col].color = p.color
          end
        end
      end
    end
  end
end
