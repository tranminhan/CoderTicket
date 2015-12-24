class AdminEventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    @event.status = :Draft

    if @event.save
      flash[:success] = "Create '#{@event.name}' successfully"
      redirect_to admin_events_path 
    else
      render 'admin_events/new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if params[:publish]
      if @event.publish
        flash[:success] = "Publish '#{@event.name}' successfully"
        return redirect_to admin_events_path
      else 
        flash[:error] = @event.errors.full_messages[0]
        render 'admin_events/show'
      end 
    elsif params[:archive]
      if @event.archive
        flash[:success] = "Archive '#{@event.name}' successfully"
        return redirect_to admin_events_path
      else 
        flash[:error] = @event.errors.full_messages[0]
        render 'admin_events/show'
      end 
    else
      render 'admin_events/show'
    end
  end

  def index
    @events = Event.all
  end

  private 

  def event_params
    params.require(:event)
          .permit(:name, :extended_html_description, :starts_at, :venue_id, :category_id, :hero_image_url)
  end

end
