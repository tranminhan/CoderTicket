require 'rails_helper'

RSpec.describe AdminTicketsController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end 
end
