class RemoveSubtitleFromPieces < ActiveRecord::Migration
  def change
    remove_column :pieces, :subtitle, :string
  end
end
