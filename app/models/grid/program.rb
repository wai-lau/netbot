class Grid
  class Program
    attr_accessor :name
    attr_accessor :color
    attr_accessor :max_size
    attr_accessor :sector_list
    attr_accessor :move

    def current_size
      if @sector_list.nil?
        return 0
      else
        return @sector_list.length
      end
    end
  end
end

