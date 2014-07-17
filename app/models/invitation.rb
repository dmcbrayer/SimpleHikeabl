class Invitation < ActiveRecord::Base
	#create the join model between users and trips.  This covers the trips that users go on, but don't create.
	belongs_to :attendee, class_name: "User"
	belongs_to :attended_trip, class_name: "Trip"
end
