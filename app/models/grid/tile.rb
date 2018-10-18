class Grid
  class Tile
    attr_accessor :type
    attr_accessor :color

    def initialize(tile={type: :empty})
      @type = tile[:type]
    end
  end
end

