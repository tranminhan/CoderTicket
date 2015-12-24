require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe "tickets validation" do
    before(:each) do
       @user = FactoryGirl.create(:user)
       venue = FactoryGirl.create(:venue)
       category = FactoryGirl.create(:category)

       # @event1 = FactoryGirl.create(:event, name: 'event test 1', starts_at: 1.day.from_now)
       @event1 = Event.new(name: "event test 1", starts_at: 1.day.from_now, venue: venue, category: category, extended_html_description: "desc - search text", status: 'Published')
       @ticket_type_1 = TicketType.create(event: @event1, price: 100000, name: 'standard', max_quantity: 100)
       @ticket_type_2 = TicketType.create(event: @event1, price: 500000, name: 'vip',      max_quantity: 2)
       
       # @event_2 = FactoryGirl.create(:event, name: 'event test 2', starts_at: 1.day.ago)
       @event_2 = Event.new(name: "event test 2", starts_at: 1.day.ago, venue: venue, category: category, extended_html_description: "desc - search text", status: 'Published')
       @ticket_type_3 = TicketType.create(event: @event_2, price: 100000, name: 'standard', max_quantity: 100)
       @ticket_type_4 = TicketType.create(event: @event_2, price: 500000, name: 'vip',      max_quantity: 2)
     end

    it "can buy tickets" do
      @ticket = Ticket.new(user: @user)
      @ticket.ticket_items << TicketItem.new(ticket_type: @ticket_type_1, qty: 1)
      @ticket.ticket_items << TicketItem.new(ticket_type: @ticket_type_2, qty: 1)

      expect(@ticket.save).to be(true)
      expect(@ticket.ticket_items(true).count).to eq(2)
    end 

    it "cannot buy more tickets than the quantity available" do
      @ticket = Ticket.new(user: @user)
      @ticket.ticket_items << TicketItem.new(ticket_type: @ticket_type_1, qty: 1)
      @ticket.ticket_items << TicketItem.new(ticket_type: @ticket_type_2, qty: 3)

      expect(@ticket.valid?).to be(false)
      expect(@ticket.ticket_items[0].errors.messages).to be_empty
      expect(@ticket.ticket_items[1].errors.messages[:qty]).to eq(['cannot buy more than max_quantity'])
    end 

    it "cannot buy more than 10 tickets per type a time" do
      @ticket = Ticket.new(user: @user)
      @ticket.ticket_items << TicketItem.new(ticket_type: @ticket_type_1, qty: 12)

      expect(@ticket.valid?).to be(false)
      expect(@ticket.ticket_items[0].errors.messages[:qty]).to eq(['cannot buy more than 10 tickets of this type a time'])
    end 

    it "cannot buy tickets to events that occur in the past" do
      @ticket = Ticket.new(user: @user)
      @ticket.ticket_items << TicketItem.new(ticket_type: @ticket_type_3, qty: 1)

      expect(@ticket.valid?).to be(false)
      expect(@ticket.ticket_items[0].errors.messages[:qty]).to eq(['cannot buy tickets for past events'])
    end 
  end 
end
