class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    # debugger
    # { ticket[1] => 2, ticket[2] => 0 }

    # Ticket
    #   Ticket_item
    #     ticket_type_id
    #     qty

    # ticket = params[:ticket] 
    # @tickets = 
    # if Ticket.new(current_user).add_all(params['ticket']).save?
    #   # show error
    # end 
    # redirect_to_thank_you page / ticket/1

    ticket.each do |key, value| 
      if value.to_i > 0 
        @tickets << { type: TicketType.find(key), qty: value }
      end 
    end
    @total = @tickets.inject(0){ |sum, e| sum += e[:type][:price].to_f }
    # debugger
  end

end
