class AdminTicketsController < ApplicationController
  before_action :require_login

  def new
    @ticket_type = TicketType.new
    @event = Event.find(params[:admin_event_id])
  end 

  def create
    @event = Event.find(params[:admin_event_id])
    @ticket_type = TicketType.create(ticket_type_params)
    @event.ticket_types << @ticket_type

    if @event.save
      redirect_to admin_event_path(@event)
    else 
      render 'new'
    end
  end 

  private 

  def ticket_type_params
    params.require(:ticket_type).permit(:name, :price, :max_quantity)
  end

end
