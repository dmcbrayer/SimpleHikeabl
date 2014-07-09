class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:show, :edit, :update, :destroy]


  def index
    @pending_trips = current_user.trips.where("starts_on >= ?", Time.now).order("starts_on ASC")
    @past_trips = current_user.trips.where("starts_on < ?", Time.now).order("starts_on ASC")
  end

  def show
    @creator = User.find(@trip.created_by)
  end

  def new
    @trip = current_user.trips.new
  end

  def edit
    @user = User.find(@trip.created_by)
    if current_user != @user
      redirect_to root_url, notice: "That's not your trip to edit!"
    end 
  end

  def create
    @trip = current_user.trips.new(trip_params)
    @trip.created_by = current_user.id
    calculate_meals(@trip)

    respond_to do |format|
      if @trip.save
        current_user.trips << @trip
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:location, :description, :name, :starts_on, :ends_on, :improvements, users_attributes: [:_destroy, :id])
    end

    #calculates the number of meals needed for the trip
    def calculate_meals(trip)
      
      t1 = trip.starts_on.to_time.to_i
      t2 = trip.ends_on.to_time.to_i

      seconds = t2-t1
      days = seconds / 86400

      trip.meals = days * 3

    end
end
