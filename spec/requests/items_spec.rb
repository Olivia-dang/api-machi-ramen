require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET /items" do
    before do
      get "/items"
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

end
