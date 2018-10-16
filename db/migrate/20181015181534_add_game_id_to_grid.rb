class AddGameIdToGrid < ActiveRecord::Migration[5.0]
  def change
    add_column :grids, :game_id, :integer
  end
end
