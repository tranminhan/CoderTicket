require 'rails_helper'

RSpec.describe AdminEventsController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end 

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
