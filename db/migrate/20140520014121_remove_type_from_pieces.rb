class RemoveTypeFromPieces < ActiveRecord::Migration
  def change
    remove_column :pieces, :type, :string
  end
end
