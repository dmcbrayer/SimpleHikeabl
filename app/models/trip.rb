class Trip < ActiveRecord::Base
	belongs_to :user

	validates :location, presence: true
	validates_date :ends_on, :on_or_after => :starts_on, :on_or_after_message => 'must be on or after starts on date'
end
