class AddSubtitleToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :subtitle, :text
  end
end
