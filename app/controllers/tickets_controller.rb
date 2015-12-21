class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    # @ticket = Ticket.new
  end

  def create
    
  end

end
