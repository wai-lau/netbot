require 'minitest/autorun'

class GridTest
  class TileReaderTest < MiniTest::Test
    def test_tilereader_creates_tile_array
      tiles = Grid::TileReader.read(blank10)
      assert tiles.length == 10
      assert tiles[0].length == 10
      assert_instance_of Grid::Tile, tiles[0][0]
    end
    
    def blank10
      [*0..9].map { |i| [*0..9].map { |j| "#{i} : #{j}" } }
    end
  end
end
