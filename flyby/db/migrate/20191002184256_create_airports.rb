class CreateAirports < ActiveRecord::Migration[6.0]
  def change
    create_table :airports do |t|
      t.string :code, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
