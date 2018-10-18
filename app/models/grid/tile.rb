class Grid
  class Tile
    attr_accessor :type
    attr_accessor :color
    attr_accessor :owner

    def initialize(tile={type: :empty})
      @type = tile[:type]
    end
  end
end

