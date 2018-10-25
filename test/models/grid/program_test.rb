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
      assert_equal program.max_size, 3
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
      state[:mode] = :move
      hack.sector_list = [[1,2],[1,1]]
      
      Grid::StateUpdater.update_all(state[:tiles], state[:programs])
      
      hack.move("l", state)

      assert_equal 3, hack.cur_size
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
      state[:mode] = :move
      hack.sector_list = [[1,2],[1,1],[1,0],[0,0]]
      
      Grid::StateUpdater.update_all(state[:tiles], state[:programs])
      
      hack.move("l", state)

      assert_equal hack.sector_list.first, [1,3]
      assert state[:tiles][0][0].owner.nil?
    end

    def test_move_into_self
      state = Grid::StageLoader.load(:blank10)
      
      hack = Grid::Program.new(:hack)
      state[:programs] = [
        hack
      ]
      state[:mode] = :move
      hack.sector_list = [[1,2],[1,1],[1,0]]
      
      Grid::StateUpdater.update_all(state[:tiles], state[:programs])
      
      hack.move("h", state)

      assert_equal hack.sector_list.length, 3
      assert_equal hack.sector_list.first, [1,1]
    end

    def test_program_highlights_correct_target_zone
      state = Grid::StageLoader.load(:blank10)

      shot = Grid::Program.new(:slingshot)
      shot.sector_list = [[1,1]]
      state[:programs] = [shot]
      state[:selected_program] = 0
      state[:mode] = :move
      
      Grid::StateUpdater.update_all(state[:tiles], state[:programs])

      shot.move("a", state)
      
      should_be_highlighted = [
        [0,0],[0,1],[0,2],[0,3],
        [1,0],[1,1],[1,2],[1,3],[1,4],
        [2,0],[2,1],[2,2],[2,3],
        [3,0],[3,1],[3,2],
              [4,1]
      ]

      assert_equal state[:tiles].flatten.select{ |t| t.highlight }.length,
        should_be_highlighted.length

      assert should_be_highlighted.all? do |row, col|
        state[:tiles][row][col].highlight
      end
    end
    
    def test_program_enters_target_mode_and_deletes_program
      state = Grid::StageLoader.load(:blank10)

      shot = Grid::Program.new(:slingshot)
      shot.sector_list = [[1,1]]
      golem = Grid::Program.new(:golem)
      golem.sector_list = [[1,3],[1,4]]
      state[:programs] = [shot, golem]
      state[:selected_program] = 0
      state[:mode] = :move
      
      Grid::StateUpdater.update_all(state[:tiles], state[:programs])

      shot.move("a", state)
      state[:mode] = :target
      shot.move("l", state)
      shot.move("k", state)
      shot.move("a", state)
      
      assert_equal 2, golem.cur_size  
      assert_equal 1, shot.cur_size  

      state[:mode] = :move
      shot.move("a", state)
      state[:mode] = :target
      shot.move("l", state)
      shot.move("l", state)
      shot.move("a", state)

      assert !state[:programs].include?(golem)
      assert_equal 1, shot.cur_size
    end
  end
end
