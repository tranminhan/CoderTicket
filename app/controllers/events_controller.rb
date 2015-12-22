class EventsController < ApplicationController
  def index
    if params[:search]
      @events = Event.where("extended_html_description like ?", "%#{params[:search]}%")
    else 
      @events = Event.upcoming
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end

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

  private 

  def event_params
    params.require(:event).permit(:name, :extended_html_description, :starts_at, :venue_id, :category_id, :hero_image_url)
  end

end
