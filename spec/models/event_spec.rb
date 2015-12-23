require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "upcoming events" do
    before do
      region = Region.create(name: "Ho Chi Minh City")
      category = Category.create(name: "Entertainment")
      venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
      @event1 = Event.create(name: "event 1", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc", status: 'Published')
      @event2 = Event.create(name: "event 2", starts_at: 2.day.from_now,   venue: venue, category: category, extended_html_description: "desc", status: 'Published')
      @event3 = Event.create(name: "event 3", starts_at: 1.day.ago,        venue: venue, category: category, extended_html_description: "desc", status: 'Published')
      @event4 = Event.create(name: "event 4", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc", status: 'Draft')
      @event5 = Event.create(name: "event 5", starts_at: 2.day.ago,        venue: venue, category: category, extended_html_description: "desc", status: 'Expired')
      @event6 = Event.create(name: "event 6", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc", status: 'Draft')

      @ticket_type_1 = TicketType.create(event: @event6, price: 100000, name: 'standard', max_quantity: 100)
      @ticket_type_2 = TicketType.create(event: @event6, price: 500000, name: 'vip',      max_quantity: 2)
      @event6.ticket_types << @ticket_type_1
      @event6.ticket_types << @ticket_type_2
     end

    it "upcoming returns future events" do
      expect(Event.upcoming).to eq([@event1, @event2])
    end 

    it "cannot publish events without a ticket type" do
      expect(@event4.publish).to be(false)
      expect(@event4.errors.messages[:ticket_types][0]).to eq("require at least one ticket type")
    end 

    it "publish events" do
      expect(@event6.publish).to be(true)
      expect(@event6.reload.status).to eq('Published')
    end 

  end 
end
