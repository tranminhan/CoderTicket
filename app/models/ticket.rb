class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :ticket_items

  validates_associated :ticket_items
  
end
