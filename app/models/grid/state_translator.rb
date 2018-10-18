class Grid
  class StateTranslator < Grid
    class << self
      def read(state, programs=[])
        state = state.map do |row|
          row.map do |tile|
            Grid::Tile.new(tile)
          end
        end
        claim_tiles(state, programs) unless programs.empty?
        state
      end

      private

      def claim_tiles(state, programs)
        programs.each do |p|
          p.sector_list.each do |coord|
            row, col = coord
            state[row][col].type = :program
          end
        end
      end
    end
  end
end
