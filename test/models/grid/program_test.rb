require 'minitest/autorun'

class GridRecordTest
  class ProgramTest < MiniTest::Test
    def test_program_can_empty_program 
      program = Grid::Program.new
      assert !program.nil?
    end
    
    def test_program_can_create_hack 
      program = Grid::Program.new(:hack)
      assert_equal program.name, "Hack 1.0"
      assert_equal program.max_size, 4
    end
    
    def test_program_can_create_slingshot 
      program = Grid::Program.new(:slingshot)
      assert_equal program.name, "Slingshot"
      assert_equal program.max_size, 3
    end

    def test_program_can_move
      state = Grid::StageLoader.load(:blank10)
      
      hack = Grid::Program.new(:hack)
      state[:programs] = [
        hack
      ]
      hack.sector_list = [[1,2],[1,1]]
      
      Grid::StateUpdater.update_all(state[:tiles], state[:programs])
      
      hack.move("l", state[:tiles])

      assert_equal hack.sector_list.length, 3
      assert_equal hack.sector_list.first, [1,3]
      assert state[:tiles][1][3].owner == hack
      assert state[:tiles][1][3].owner == hack
    end

    def test_program_deletes_last_sector
      state = Grid::StageLoader.load(:blank10)
      
      hack = Grid::Program.new(:hack)
      state[:programs] = [
        hack
      ]
      hack.sector_list = [[1,2],[1,1],[1,0],[0,0]]
      
      Grid::StateUpdater.update_all(state[:tiles], state[:programs])
      
      hack.move("l", state[:tiles])

      assert_equal hack.sector_list.first, [1,3]
      assert state[:tiles][0][0].owner.nil?
    end

    def test_move_into_self
      state = Grid::StageLoader.load(:blank10)
      
      hack = Grid::Program.new(:hack)
      state[:programs] = [
        hack
      ]
      hack.sector_list = [[1,2],[1,1],[1,0]]
      
      Grid::StateUpdater.update_all(state[:tiles], state[:programs])
      
      hack.move("h", state[:tiles])

      assert_equal hack.sector_list.length, 3
      assert_equal hack.sector_list.first, [1,1]
    end

    def test_program_returns_correct_highlight_zone

    end
  end
end
