class AdminEventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    if @event.save
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def index
    @events = Event.all
  end

  private 

  def event_params
    params.require(:event).permit(:name, :extended_html_description, :starts_at, :venue_id, :category_id, :hero_image_url)
  end

end
