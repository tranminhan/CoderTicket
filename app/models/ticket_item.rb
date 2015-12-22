class TicketItem < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :ticket_type

  validate :qty_less_than_max_qty

  private 
  
  def qty_less_than_max_qty
    if qty > self.ticket_type.max_quantity
      errors.add(:qty, "cannot buy more than max_quantity")
    end
  end

end
