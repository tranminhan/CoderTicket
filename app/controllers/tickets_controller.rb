class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def create
    # debugger
    @ticket = Ticket.new(user: current_user)
    params[:ticket].each do |key, value| 
      if value.to_i > 0 
        @ticket.ticket_items << TicketItem.new(ticket_type: TicketType.find(key), qty: value)
      end 
    end

    if @ticket.save
      redirect_to ticket_path(@ticket)
    else
      render text: "Cannot process this purchase"
    end 
  end

end
