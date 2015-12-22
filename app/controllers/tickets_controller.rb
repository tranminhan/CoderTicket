class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def create
    # debugger
    # { ticket[1] => 2, ticket[2] => 0 }

    # Ticket
    #   Ticket_item
    #     ticket_type_id
    #     qty

    # ticket = params[:ticket] 
    @ticket = Ticket.new(user: current_user)
    #   # show error
    # end 
    # redirect_to_thank_you page / ticket/1
    params[:ticket].each do |key, value| 
      if value.to_i > 0 
        @ticket.ticket_items << TicketItem.new(ticket_type: TicketType.find(key), ticket: @ticket, qty: value)
      end 
    end

    # debugger
    if @ticket.save
      redirect_to ticket_path(@ticket)
    else
      render text: "Cannot process this purchase"
    end 

    # @total = @tickets.inject(0){ |sum, e| sum += e[:type][:price].to_f }
    # debugger
  end

end
