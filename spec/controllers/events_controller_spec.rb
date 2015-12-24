require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    venue = FactoryGirl.create(:venue)
    category = FactoryGirl.create(:category)

    @event1 = FactoryGirl.create(:event, name: 'event test 1', extended_html_description: "desc - search text", venue: venue, category: category)
    @event2 = FactoryGirl.create(:event, name: 'event test 2', venue: venue, category: category)
    @event3 = FactoryGirl.create(:event, name: 'event test 3', venue: venue, category: category)
  end

  it "search for events by name" do 
    get :index, search: 'search text'

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(assigns(:events)).to eq([@event1])

    expect(response).to render_template('index')
  end 

end
