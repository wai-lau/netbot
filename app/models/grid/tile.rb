class Grid
  class Tile
    attr_accessor :type
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

    def ==(other)
      return false unless other.kind_of?(self.class)
      self.type == other.type &&
      self.owner == other.owner &&
      self.head == other.head
    end
  end
end

