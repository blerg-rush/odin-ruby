class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.integer :from_id, foreign_key: true
      t.integer :to_id, foreign_key: true

      t.timestamps
    end
  end
end
