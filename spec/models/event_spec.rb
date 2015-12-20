require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "upcoming events" do
    before do
       region = Region.create(name: "Ho Chi Minh City")
       category = Category.create(name: "Entertainment")
       venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
       @event1 = Event.create(name: "event 1", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc")
       @event2 = Event.create(name: "event 2", starts_at: 2.day.from_now,   venue: venue, category: category, extended_html_description: "desc")
       @event3 = Event.create(name: "event 3", starts_at: 1.day.ago,        venue: venue, category: category, extended_html_description: "desc")
     end

    it "upcoming returns future events" do
      expect(Event.upcoming).to eq([@event1, @event2])
    end 
  end 
end
