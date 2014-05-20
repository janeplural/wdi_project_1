class AddCostToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :cost, :string
  end
end
