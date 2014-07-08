class Trip < ActiveRecord::Base
	has_and_belongs_to_many :users

	validates :location, presence: true
	validates_date :ends_on, :on_or_after => :starts_on, :on_or_after_message => 'must be on or after starts on date'
end
