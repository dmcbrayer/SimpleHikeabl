class Trip < ActiveRecord::Base

	has_and_belongs_to_many :users

	validates :location, presence: true
	validates_date :ends_on, :on_or_after => :starts_on, :on_or_after_message => 'must be on or after starts on date'
	
	#this basically ensures that we get both the trips that the user made and the trips 
	#that the user went on, while discarding duplicates.
	scope :for_user, -> (user) {
		joins("left outer join trips_users on trips.id=trips_users.trip_id").
			where("trips_users.user_id = ? OR trips.created_by = ?", user.id, user.id).
			uniq
	}

	# def for_user user
	# 	(user.created_trips + user.trips).uniq
	# end

	#calculates the number of meals needed for the trip
    def calculate_meals
      
      t1 = self.starts_on.to_time.to_i
      t2 = self.ends_on.to_time.to_i

      seconds = t2-t1
      days = seconds / 86400

      self.meals = days * 3

    end

end

