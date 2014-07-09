# app/helpers/form_helper
module FormHelper
  def setup_trip(trip)
    (User.all - trip.users).each do |user|
      trip.users.build(:user => user)
    end
  end
end