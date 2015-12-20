require 'rails_helper'

RSpec.describe "routes for events", type: :routing do

  it "routes for index" do
    expect(get("/")).to route_to("events#index")
  end 

  it "routes for index" do
    expect(get("/?search=some events")).to route_to(controller: "events", action: "index", search: "some events")
  end 

end
