class AddMealsToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :meals, :integer
  end
end
