class Grid
  class Tile
    attr_accessor :type

    def initialize(tile)
      @type = tile[:type]
    end
  end
end

