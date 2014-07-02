class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :player_id
      t.string :text

      t.timestamps
    end
  end
end
