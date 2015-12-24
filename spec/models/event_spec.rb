require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each) do
    venue = FactoryGirl.create(:venue)
    category = FactoryGirl.create(:category)

    @event1 = FactoryGirl.create(:event, name: 'event test 1', venue: venue, category: category)
    @event2 = FactoryGirl.create(:event, name: 'event test 2', venue: venue, category: category)
    # @event3 = FactoryGirl.create(:event, name: 'event 3')
    # @event4 = FactoryGirl.create(:event, name: 'event 4')
    # @event5 = FactoryGirl.create(:event, name: 'event 5')
    # @event6 = FactoryGirl.create(:event, name: 'event 6')

    # @ticket_type_1 = TicketType.create(event: @event6, price: 100000, name: 'standard', max_quantity: 100)
    # @ticket_type_2 = TicketType.create(event: @event6, price: 500000, name: 'vip',      max_quantity: 2)
    # @event6.ticket_types << @ticket_type_1
    # @event6.ticket_types << @ticket_type_2
  end

  describe "upcoming events" do

    it "upcoming returns future events" do
      expect(Event.upcoming).to eq([@event1, @event2])
    end 

    # it "cannot publish events without a ticket type" do
    #   expect(@event4.publish).to be(false)
    #   expect(@event4.errors.messages[:ticket_types][0]).to eq("require at least one ticket type")
    # end 

    # it "publish events" do
    #   expect(@event6.publish).to be(true)
    #   expect(@event6.reload.status).to eq('Published')
    # end 

    # it "archive events" do
    #   expect(@event6.archive).to be(true)
    #   expect(@event6.reload.status).to eq('Archived')
    # end 

  end 
end
