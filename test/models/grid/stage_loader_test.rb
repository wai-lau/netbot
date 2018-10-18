require 'minitest/autorun'

class GridRecordTest
  class StageLoaderTest < MiniTest::Test
    def test_tiles_loader_can_load_blank_tiles
      tiles = Grid::StageLoader.load(:blank10)[:tiles]
      assert tiles.length == 10
      assert tiles[0].length == 10
      assert_instance_of Grid::Tile, tiles[0][0]
    end

    def test_tilesloader_properly_creates_first_tile
      tiles = Grid::StageLoader.load(:blank10)[:tiles]
      assert_equal tiles[0][0].type, :empty
    end
    
    def test_tilesloader_creates_tiles_with_test_programs
      tiles = Grid::StageLoader.load(:hack10)[:tiles]
      assert tiles.flatten.select { |t| t.type == :program }.length == 7
      
      assert [tiles[0][3],
              tiles[6][7],
              tiles[0][3]].all? do |t| 
        !(t.type == :program)
      end

      assert [tiles[0][4],
              tiles[6][6]].all? do |t| 
        t.type == :empty
      end
    end
  end
end
