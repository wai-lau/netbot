require 'minitest/autorun'

class GridTest
  class ProgramTest < MiniTest::Test
    def test_example 
      program = Grid::Program.new
      assert !program.nil?
    end
  end
end
