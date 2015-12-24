require 'rails_helper'

RSpec.feature "Events", type: :feature do
  before (:each) do
    venue = FactoryGirl.create(:venue)
    category = FactoryGirl.create(:category)

    @event1 = FactoryGirl.create(:event, name: 'event 1', starts_at: 2.days.from_now, venue: venue, category: category)
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