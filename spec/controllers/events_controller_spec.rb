require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    region = Region.create(name: "Ho Chi Minh City")
    category = Category.create(name: "Entertainment")
    venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
    @event1 = Event.create(name: "event 1", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc - search text")
    @event2 = Event.create(name: "event 2", starts_at: 2.day.from_now,   venue: venue, category: category, extended_html_description: "desc")
    @event3 = Event.create(name: "event 3", starts_at: 1.day.ago,        venue: venue, category: category, extended_html_description: "desc")
  end

  it "search for events by name" do 
    get :index, search: 'search text'
    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(assigns(:events)).to eq([@event1])
    expect(response).to render_template('index')
  end 

end
