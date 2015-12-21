require 'rails_helper'

RSpec.feature "Events", type: :feature do
  before do
    region = Region.create(name: "Ho Chi Minh City")
    category = Category.create(name: "Entertainment")
    venue = Venue.create(name: "venue name", full_address: "venue addr", region: region)
    @event1 = Event.create(name: "event 1", starts_at: 1.day.from_now,   venue: venue, category: category, extended_html_description: "desc - search text")
  end

  # Scenario: Visit the 'about' page
  #   Given I am a visitor
  #   When I visit the 'about' page
  #   Then I see "About the Website"
  scenario 'Visit the home page' do
    visit root_path
    expect(page).to have_content 'Discover upcoming events'
  end

  scenario 'Follow an event detail page' do
    visit root_path
    click_link 'event 1'
    expect(page).to have_selector('h3', text: 'event 1')
  end

  scenario 'Book now leads into another page to purchase tickets' do
    visit event_path(@event1)
    expect(page).to have_selector('h3', text: 'event 1')
    click_link 'BOOK NOW'
    expect(page).to have_selector '.tickets-buy'
  end

end