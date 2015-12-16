require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "upcoming events" do
    it "upcoming returns future events" do
      Event.create!(name: 'event 1', starts_at: DateTime.now - 1.day, extended_html_description: 'a')
      Event.create!(name: 'event 2', starts_at: DateTime.now,         extended_html_description: 'b')
      Event.create!(name: 'event 3', starts_at: DateTime.now + 1.day, extended_html_description: 'c')
      expect(Event.upcoming.count).to eq(2)
    end 
  end 
end
