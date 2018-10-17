class AddStateToGrid < ActiveRecord::Migration[5.0]
  def change
    add_column :grids, :state, :text
  end
end
