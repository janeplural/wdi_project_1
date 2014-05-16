class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :title
      t.string :subtitle
      t.string :thumbnail
      t.string :type
      t.string :pub_date
      t.string :preview
      t.text :description

      t.timestamps
    end
  end
end
