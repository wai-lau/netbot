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
        programs = claim_tiles(stage, STAGE[stage_name][:programs])
        
        {tiles: stage, programs: programs}
      end

      private

      def spawn_program(sector_list, name_symbol)
        p = Grid::Program.new(name_symbol)
        p.sector_list = sector_list
        p
      end

      def claim_tiles(stage, program_data)
        programs = program_data.map do |data|
          spawn_program(data[:sector_list], data[:name_symbol])
        end
        programs.each do |p|
          p.sector_list.each do |coord|
            row, col = coord
            stage[row][col].type = :program
          end
        end
        programs
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
        }
      }
    end
  end
end
