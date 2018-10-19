require 'minitest/autorun'

class GridRecordTest
  class StateUpdaterTest < MiniTest::Test
    def test_state_updater_will_load_in_new_programs
      blank10_tiles = Grid::StageLoader.load(:blank10)[:tiles]
      hack10_programs = Grid::StageLoader.load(:hack10)[:programs]
     
      Grid::StateUpdater.update_all(
        blank10_tiles, 
        hack10_programs
      )
      
      assert blank10_tiles[0][0].owner.name == "Hack 1.0"
      assert blank10_tiles[7][7].owner.name == "Slingshot"
    end
  end
end
