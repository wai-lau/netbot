require 'minitest/autorun'

class GridRecordTest
  class StateShrinkerTest < MiniTest::Test
    def test_state_shrinker_will_reduce_state_size
      hack10 = Grid::StageLoader.load(:hack10)
      ministate = Grid::StateShrinker.shrink(hack10)
      assert_equal ministate[:tile_types].length, 5
      assert_equal ministate[:programs].length, 2
    end
  end
end
