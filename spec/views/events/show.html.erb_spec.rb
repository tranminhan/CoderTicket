require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before do
    region = Region.new(name: "Ho Chi Minh City")
    category = Category.new(name: "Entertainment")
    venue = Venue.new(name: "venue name", full_address: "venue addr", region: region)
    @event1 = Event.new(name: "event 1", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc - search text")
  end

  # it "display the link to event detail page" do
  #   assign(:event, @event1)
  #   render
  #   expect(rendered).to include("Chicago")
  # end
end
