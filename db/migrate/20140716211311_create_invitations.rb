class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :attendee_id
      t.integer :attended_trip_id
      
      t.timestamps
    end
  end
end
