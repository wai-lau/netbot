[1mdiff --git a/app/models/grid/tile.rb b/app/models/grid/tile.rb[m
[1mindex e6d823f..36da5cb 100644[m
[1m--- a/app/models/grid/tile.rb[m
[1m+++ b/app/models/grid/tile.rb[m
[36m@@ -1,7 +1,6 @@[m
 class Grid[m
   class Tile[m
     attr_accessor :type[m
[31m-    attr_accessor :color[m
     attr_accessor :owner[m
     attr_accessor :head[m
 [m
[36m@@ -18,6 +17,13 @@[m [mclass Grid[m
       @head = false[m
       @owner = nil[m
     end[m
[32m+[m
[32m+[m[32m    def ==(other)[m
[32m+[m[32m      return false unless other.kind_of?(self.class)[m
[32m+[m[32m      self.type == other.type &&[m
[32m+[m[32m      self.owner == other.owner &&[m
[32m+[m[32m      self.head == other.head[m
[32m+[m[32m    end[m
   end[m
 end[m
 [m
[1mdiff --git a/test/models/grid/state_updater_test.rb b/test/models/grid/state_updater_test.rb[m
[1mindex d4bb952..010d075 100644[m
[1m--- a/test/models/grid/state_updater_test.rb[m
[1m+++ b/test/models/grid/state_updater_test.rb[m
[36m@@ -1,6 +1,18 @@[m
 require 'minitest/autorun'[m
 [m
 class GridRecordTest[m
[31m-  class StateShrinkerTest < MiniTest::Test[m
[32m+[m[32m  class StateUpdaterTest < MiniTest::Test[m
[32m+[m[32m    def test_state_updater_will_load_in_new_programs[m
[32m+[m[32m      blank10_tiles = Grid::StageLoader.load(:blank10)[:tiles][m
[32m+[m[32m      hack10_programs = Grid::StageLoader.load(:hack10)[:programs][m
[32m+[m[41m     [m
[32m+[m[32m      Grid::StateUpdater.update_all([m
[32m+[m[32m        blank10_tiles,[m[41m [m
[32m+[m[32m        hack10_programs[m
[32m+[m[32m      )[m
[32m+[m[41m      [m
[32m+[m[32m      assert blank10_tiles[0][0].owner.name == "Hack 1.0"[m
[32m+[m[32m      assert blank10_tiles[7][7].owner.name == "Slingshot"[m
[32m+[m[32m    end[m
   end[m
 end[m
