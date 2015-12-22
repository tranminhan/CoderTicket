require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "tickets validation" do
    before do
       region = FactoryGirl.create(:hcm)
       category = Category.create(name: "Entertainment")
       venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
       @event1 = Event.create(name: "event 1", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc")
       @ticket_type_1 = TicketType.create(event: @event1, price: 100000, name: 'standard', max_quantity: 10)
       @ticket_type_2 = TicketType.create(event: @event1, price: 500000, name: 'vip',      max_quantity: 2)
       @user = FactoryGirl.create(:user)
     end

    it "cannot buy more tickets than the quantity available" do
      @ticket = Ticket.new(user: @user)
      @ticket.ticket_items << TicketItem.new(ticket_type: @ticket_type_1, ticket: @ticket, qty: 1)
      @ticket.ticket_items << TicketItem.new(ticket_type: @ticket_type_2, ticket: @ticket, qty: 3)

      expect(@ticket.valid?).to be(false)
      expect(@ticket.ticket_items[0].errors.messages).to be_empty
      expect(@ticket.ticket_items[1].errors.messages[:qty]).to eq(['cannot buy more than max_quantity'])
    end 
  end 
end
