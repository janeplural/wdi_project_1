class CreateReadrs < ActiveRecord::Migration
  def change
    create_table :readrs do |t|
      t.integer :piece_id
      t.integer :user_id
      t.boolean :read

      t.timestamps
    end
  end
end
