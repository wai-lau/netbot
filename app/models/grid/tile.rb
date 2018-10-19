class Grid
  class Tile
    attr_accessor :type
    attr_accessor :color
    attr_accessor :owner
    attr_accessor :head

    def initialize(tile={type: :empty})
      @type = tile[:type]
    end

    def space?
      @type == :empty
    end

    def clear
      @type = :empty
      @head = false
      @owner = nil
    end
  end
end

