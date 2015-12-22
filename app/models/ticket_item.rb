class TicketItem < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :ticket_type

  validate :qty_less_than_max_qty, :qty_less_than_10, :future_event

  private 
  
  def qty_less_than_max_qty
    if qty > self.ticket_type.max_quantity
      errors.add(:qty, "cannot buy more than max_quantity")
    end
  end

  def qty_less_than_10
    if qty > 10 
      errors.add(:qty, "cannot buy more than 10 tickets of this type a time")
    end 
  end 

  def future_event
    unless ticket_type.event.future?
      errors.add(:qty, "cannot buy tickets for past events")
    end 
  end 
end
