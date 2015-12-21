class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    # debugger
    ticket = params[:ticket]
    @tickets = []
    ticket.each do |key, value| 
      if value.to_i > 0 
        @tickets << { type: TicketType.find(key), qty: value }
      end 
    end
    @total = @tickets.inject(0){ |sum, e| sum += e[:type][:price].to_f }
    # debugger
  end

end
