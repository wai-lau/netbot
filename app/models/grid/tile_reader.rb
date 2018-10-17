class Grid
  class TileReader < Grid
    def self.read(state)
      state.map do |row|
        row.map do |tile|
          Tile.new(tile)
        end
      end
    end 
  end
end
