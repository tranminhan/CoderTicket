require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    venue = FactoryGirl.create(:venue)
    category = FactoryGirl.create(:category)

    @event1 = Event.create(name: "event 1", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc - search text", status: 'Published')
  end

  it "display the book now button" do
    assign(:event, @event1)
    render
    expect(rendered).to include("BOOK NOW")
  end
end
