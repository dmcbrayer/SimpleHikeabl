class Invitation < ActiveRecord::Base
	belongs_to :attendee, class_name: "User"
	belongs_to :attended_trip, class_name: "Trip"
end
