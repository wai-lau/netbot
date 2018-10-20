class Grid
  class StateShrinker < Grid
    class << self
      def shrink(state)
        tile_types = []
        reference_map = state[:tiles].map do |row|
          row.map do |t|
            reference = nil
            tile_types.each.with_index do |type, i|
              reference = i if t == type
            end
            if reference.nil?
              tile_types << t
              reference = tile_types.length - 1
            end
            reference
          end
        end
        
        tile_clones = []
        tile_types.each do |type|
          reference = nil
          state[:programs].each.with_index do |program, i|
            reference = i if type.owner == program
          end
          raise "No such program!?" if reference.nil? && type.type == :program
          tile_clone = type.clone
          tile_clone.owner = reference
          tile_clones << tile_clone
        end

        { reference_map: reference_map,
          tile_types: tile_clones, 
          programs: state[:programs] }
      end
    end
  end
end
