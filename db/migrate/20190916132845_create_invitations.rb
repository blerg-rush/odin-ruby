class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.integer :status, default: 0
      t.references :event, null: false, foreign_key: true
      t.references :attendee, null: false

      t.timestamps
    end
  end
end
