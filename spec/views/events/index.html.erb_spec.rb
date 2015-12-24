require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    venue = FactoryGirl.create(:venue)
    category = FactoryGirl.create(:category)

    @event1 = Event.create(name: "event 1", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc - search text", status: 'Published')
  end

  it "display the link to event detail page" do
    assign(:events, [@event1])
    render
    expect(rendered).to match /events/#{@event1.id}/
    expect(rendered).to have_link("event 1", href: "/events/#{@event1.id}")
  end
end
