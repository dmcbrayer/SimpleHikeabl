class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.belongs_to :user
      t.date :starts_on
      t.date :ends_on
      t.string :name
      t.string :location
      t.text :description
      t.text :improvements
      t.integer :created_by

      t.timestamps
    end
    add_index :trips, :user_id
    add_index :trips, :created_by
  end
end
