class EventsController < ApplicationController
  def index
    if params[:search]
      @events = Event.where("extended_html_description like ?", "%#{params[:search]}%")
    else 
      @events = Event.upcoming
    end
  end

  def search
  end

  def show
    @event = Event.find(params[:id])
  end
end
