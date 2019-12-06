class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.references :host, null: false

      t.timestamps
    end
  end
end
