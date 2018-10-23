class Grid
  class Program
    attr_accessor :name
    attr_accessor :color
    attr_accessor :max_size
    attr_accessor :sector_list
    attr_accessor :max_move
    attr_accessor :cur_move
    attr_accessor :range

    def cur_size
      if @sector_list.nil?
        return 0
      else
        return @sector_list.length
      end
    end

    def initialize(name_symbol=nil)
      return if name_symbol.nil?
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
        @range = program_data[:range]
      end
    end

    def move(move, mode, tiles=nil)
      raise ArgumentError, "No tiles for move command." unless tiles
      case mode
      when :move
        case move
        when *%w(h j k l)
          move_program(move, tiles)
        when "a"
          highlight_attack_range(tiles)
        end
      end
    end

    def highlight_attack_range(state_tiles)
      Grid::StateUpdater.highlight(attack_range, state_tiles)
    end

    private
    
    def move_program(move, tiles)
      dest = destination(move)
      if collision?(dest, tiles) && !self_collision?(dest)
        return    
      else
        old_sectors = @sector_list.clone
        @cur_move -= 1
        @sector_list.unshift(dest)
        #deletes from the back!
        @sector_list = @sector_list.uniq
        if cur_size > @max_size
          @sector_list.pop
        end
        Grid::StateUpdater.update(tiles, self, old_sectors)
      end
    end

    def destination(move)
      row, col = @sector_list.first
      begin
        case move
        when "h"
          [row, col-1]
        when "j"
          [row+1, col]
        when "k"
          [row-1, col]
        when "l"
          [row, col+1]
        end
      end
    end

    def attack_range
      loc = @sector_list.first
      tiles = []
      [*0..(2*@range)].each do |m| 
        [*0..(2*@range)].each do |n|
          if (m-@range).abs + (n-@range).abs <= @range
            tiles << [
              loc[0]+m-@range,
              loc[1]+n-@range
            ]
          end
        end
      end
     tiles 
    end

    def collision?(destination, tiles)
      return true if destination.any? { |d| d < 0 }
      row, col = destination
      begin
        !tiles[row][col].space?
      rescue
        true
      end
    end

    def self_collision?(destination)
      @sector_list.any? {|s| s == destination}
    end

    PROGRAM_LIST = {
      hack: {
        name: "Hack 1.0",
        color: [0, 208, 208],
        max_size: 4,
        max_move: 2,
        range: 1
      },
      slingshot: {
        color: [48, 225, 160],
        max_size: 3,
        max_move: 2,
        range: 2
      },
      golem: {
        name: "Golem",
        color: [255, 192, 128],
        max_size: 7,
        max_move: 2,
        range: 1
      },
      wintermute: {
        color: [232, 243, 247],
        max_size: 35,
        max_move: 7,
        range: 5
      }
    }
  end
end

