require 'minitest/autorun'
require 'json'

class GridRecordTest
  class StateTranslatorTest < MiniTest::Test
    def test_translate_blank10_state
      tiles = Grid::StateTranslator.export(
        Grid::StageLoader.load(:blank10)
      )
      assert tiles.flatten.length == 10*10
    end

    def test_translate_state_with_programs
      tiles = Grid::StateTranslator.export(
        Grid::StageLoader.load(:hack10)
      )
      colored_tiles = tiles.flatten.select do |tile|
        tile["color"] != "white"
      end
      assert_equal colored_tiles.length, 7
    end     
  end
end
