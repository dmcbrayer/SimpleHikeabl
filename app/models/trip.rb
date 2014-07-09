class Trip < ActiveRecord::Base
	has_and_belongs_to_many :users
	accepts_nested_attributes_for :users, :allow_destroy => true

	validates :location, presence: true
	validates_date :ends_on, :on_or_after => :starts_on, :on_or_after_message => 'must be on or after starts on date'
end
