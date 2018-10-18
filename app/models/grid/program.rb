class Grid
  class Program
    attr_accessor :name
    attr_accessor :color
    attr_accessor :max_size
    attr_accessor :sector_list
    attr_accessor :max_move
    attr_accessor :cur_move

    def cur_size
      if @sector_list.nil?
        return 0
      else
        return @sector_list.length
      end
    end

    def initialize(name_symbol)
      if PROGRAM_LIST[name_symbol]
        program_data = PROGRAM_LIST[name_symbol]
        @name = if program_data[:name]
                  program_data[:name]
                else
                  name_symbol.to_s.capitalize
                end
        @color = program_data[:color]
        @max_size = program_data[:max_size]
        @max_move = program_data[:max_move]
        @cur_move = program_data[:max_move]
      end
    end

    private

    PROGRAM_LIST = {
      hack: {
        name: "Hack 1.0",
        color: "Blue",
        max_size: 4,
        max_move: 2
      },

      slingshot: {
        color: "Teal",
        max_size: 3,
        max_move: 2
      }
    }
  end
end

