class AdminEventsController < ApplicationController
  before_action :require_login
  before_action :author_check, only: [:edit, :update, :show]

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
    render 'admin_events/edit'
  end

  def create
    @event = Event.create(event_params)
    @event.status = :Draft
    @event.user = current_user

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
      if @event.update(event_params)
        flash[:success] = "Update '#{@event.name}' successfully"
        redirect_to admin_event_path(@event)
      else 
        render 'admin_events/edit'
      end 
    end
  end

  def index
    @events = Event.where("user_id = ?", current_user.id)
  end

  def index
    @events = Event.where("user_id = ?", current_user.id)
  end

  private 

  def event_params
    params.require(:event)
          .permit(:name, :extended_html_description, :starts_at, :venue_id, :category_id, :hero_image_url)
  end

  def author_check
    author = Event.find(params[:id]).user
    unless current_user == author
      flash[:error] = "You are not the admin of this event"
      redirect_to admin_events_path 
    end
  end 

end
