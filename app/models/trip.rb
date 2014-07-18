class Trip < ActiveRecord::Base

	#this part covers all the trips the user creates.  they're different from the ones that they just attend
	belongs_to :user

	#set up has_many :through relationship with the trips made by other users.  Invitations is the join table.
	has_many :invitations, :foreign_key => :attended_trip_id
	has_many :attendees, :through => :invitations 


	validates :location, presence: true

	#I apparently need to update this gem.  I don't know how to do that so I hope the developer does.
	validates_date :ends_on, :on_or_after => :starts_on, :on_or_after_message => 'must be on or after starts on date'
	
	#this basically ensures that we get both the trips that the user made and the trips 
	#that the user went on, while discarding duplicates.  Given the way I've started setting this up, this may not be necessary
	scope :for_user, -> (user) {
		joins("left outer join trips_users on trips.id=trips_users.trip_id").
			where("trips_users.user_id = ? OR trips.created_by = ?", user.id, user.id).
			uniq
	}

	#The scope Lambda immediately above is apparently preferred because it is only a single database query, where the method below includes two separate queries
	# def for_user user
	# 	(user.created_trips + user.trips).uniq
	# end

	#methods necessary to get latitude and longitude for the location
	geocoded_by :location
	after_validation :geocode

	#calculates the number of meals needed for the trip
    def calculate_meals
      
      t1 = self.starts_on.to_time.to_i
      t2 = self.ends_on.to_time.to_i

      seconds = t2-t1
      days = seconds / 86400

      self.meals = days * 3

    end

end

