class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :ticket_items

  validates_associated :ticket_items

  def total 
    ticket_items.inject(0){ |sum, e| sum += e.ticket_type.price.to_f }
  end 
  
end
