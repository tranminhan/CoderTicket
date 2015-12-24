class AdminVenuesController < ApplicationController
  before_action :require_login

  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
  end

  def create 
    @venue = Venue.create(venue_params)
    if @venue.save
      redirect_to admin_venues_path
    else
      render 'new'
    end 
  end 

  private

  def venue_params
    params.require(:venue).permit(:name, :full_address, :region_id)
  end

end
