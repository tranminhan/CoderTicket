class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def create
    @event = Event.find(params[:event_id])
    ticket = Ticket.new(user: current_user)
    params[:ticket].each do |key, value| 
      if value.to_i > 0 
        ticket.ticket_items << TicketItem.new(ticket_type: TicketType.find(key), qty: value)
      end 
    end

    if ticket.save
      redirect_to ticket_path(ticket)
    else
      flash.now[:error] = ticket.ticket_items.collect { |ti| ti.errors.full_messages } . flatten(1) . join ('\n')
      render 'new'
    end 
  end
end
