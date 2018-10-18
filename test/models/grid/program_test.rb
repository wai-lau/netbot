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
  end
end
