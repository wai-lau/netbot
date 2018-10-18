class Grid
  class Tile
    attr_accessor :type

    def initialize(tile={type: :empty})
      @type = tile[:type]
    end
  end
end

