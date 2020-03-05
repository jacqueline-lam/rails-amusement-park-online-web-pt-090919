class RidesController < ApplicationController
  before_action :require_login

  def create
    ride = Ride.create(ride_params)
    message = ride.take_ride
    flash[:notice] = message
    redirect_to user_path(ride.user)
  end

  private
  def ride_params
    params.require(:ride).permit(:user_id, :attraction_id)
  end
end