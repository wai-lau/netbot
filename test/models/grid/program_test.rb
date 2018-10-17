require 'minitest/autorun'

class GridTest
  class ProgramTest < MiniTest::Test
    def test_example 
      program = Grid::Program.new
      puts program
      assert true
    end
  end
end
