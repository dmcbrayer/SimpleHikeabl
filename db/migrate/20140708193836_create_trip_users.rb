class CreateTripUsers < ActiveRecord::Migration
  def change
    create_table :trips_users, :id => false do |t|
    	t.references :trip
    	t.references :user
    end
  end
end
