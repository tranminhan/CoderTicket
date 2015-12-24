require 'rails_helper'

RSpec.describe AdminVenuesController, type: :controller do
  before do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end 

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
