require 'minitest/autorun'

class GridTest
  class StateTranslatorTest < MiniTest::Test
    def test_tilereader_creates_tile_array
      tiles = Grid::StateTranslator.read(blank10)
      assert tiles.length == 10
      assert tiles[0].length == 10
      assert_instance_of Grid::Tile, tiles[0][0]
    end

    def test_tilereader_reads_first_tile_of_state
      tiles = Grid::StateTranslator.read(blank10)
      assert_equal tiles[0][0].type, :empty
    end
    
    def test_tilereader_reads_state_with_test_program
      tiles = Grid::StateTranslator.read(
        blank10,
        [
          create_test_program([[0,0],[0,1],[0,2],[0,3]]),
          create_test_program([[6,7],[7,7],[7,6]])
        ]
      )
      assert tiles.flatten.select { |t| t.type == :program }.length == 7
      
      assert [tiles[0][3],
              tiles[6][7],
              tiles[0][3]].all? do |t| 
        not t.owner.type == :program
      end

      assert [tiles[0][4],
              tiles[6][6]].all? do |t| 
        t.owner.type == :empty
      end
    end
    
    def blank10
      [*0..9].map do
        [*0..9].map do
          {
            type: :empty,
          }
        end
      end
    end

    def create_test_program(sector_list)
      p = Grid::Program.new
      p.name = "test_program"
      p.color = "blue"
      p.max_size = 4
      p.move = 2
      p.sector_list = sector_list
      p
    end
  end
end
