class CreatePlaythroughs < ActiveRecord::Migration[7.2]
  def change
    create_table :playthroughs do |t|
      t.references :player, null: false, foreign_key: true
      t.datetime :started_at, null: false
      t.integer :score, null: false
      t.integer :time_spent, null: false

      t.timestamps
    end
  end
end
