class Grid
  class StageLoader < Grid
    class << self
      def load(stage_name)
        return nil unless STAGE[stage_name]
        
        stage = STAGE[stage_name][:map].map do |row|
          row.map do |tile|
            Grid::Tile.new(tile)
          end
        end
        return {tiles: stage} unless STAGE[stage_name][:programs]
        
        programs = spawn_programs(STAGE[stage_name][:programs])
        Grid::StateUpdater.update_all(stage, programs)
        
        {tiles: stage, programs: programs}
      end

      private

      def spawn_programs(program_data)
        program_data.map do |data|
           p = Grid::Program.new data[:name_symbol]
           p.sector_list = data[:sector_list]
           p
        end
      end

      STAGE = {
        blank10: {
          map: [*0..9].map do
                 [*0..9].map do
                   { type: :empty }
                 end
               end
        },
        hack10: {
          map: [*0..9].map do
                 [*0..9].map do
                   { type: :empty }
                 end
               end,
          programs: [
            { name_symbol: :hack,
              sector_list: [[0,0],[0,1],[0,2],[0,3]]
            },
            { name_symbol: :slingshot,
              sector_list: [[6,7],[7,7],[7,6]] 
            },
          ]
        },
        nosec: {
          map: [*0..12].map do
                 [*0..12].map do
                   { type: :empty }
                 end
               end,
          programs: [
            { name_symbol: :hack,
              sector_list: [[0,0]]
            },
            { name_symbol: :slingshot,
              sector_list: [[12,12]]
            },
          ]
        },
      }
    end
  end
end
