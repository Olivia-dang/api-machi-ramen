require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /account" do
    it "returns 401 if user do not log in/sign up" do
      get '/account'
      expect(response).to have_http_status(:unauthorized)
    end
  end
  
  describe "GET /account" do
    before do
      sign_in create(:user, email: "admin@test.com", password: "iamhungry", id:1, role: "Regular")
    end
    it "show account if the user logged in" do
      get '/account'
      expect(response).to have_http_status(:success)
    end
  end

end
