class UsersController < ApplicationController
	before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
  	@users = User.all
  end

  def show
    #@usertrips = @user.trips.all
    @usertrips = Trip.for_user(@user).order("starts_on ASC")
    @hash = Gmaps4rails.build_markers(@usertrips) do |trip, marker|
      marker.lat trip.latitude
      marker.lng trip.longitude
      marker.infowindow trip.location
    end
  end

  private

  	def set_user
  		@user = User.find(params[:id])
  	end
end
