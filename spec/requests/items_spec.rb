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
  
  before do
    sign_in create(:user, email: "admin@test.com", password: "iamhungry", id:1, role: "Admin")
  end

  describe "POST /items" do
    let!(:category) { Category.create! name: 'foo'}
    before do
      post "/items", params: { item: { name: "Charizard", price: "10.3", category_id: category.id, user_id: 1}}
    end
    it "creates a new item" do
      expect(response).to have_http_status :created
    end
    it 'returns the item\'s id' do
      expect(JSON.parse(response.body)['name']).to eq('Charizard')
    end
  end

  describe "PUT /items/:id" do
    let!(:category) { Category.create! name: 'foo'}
    let!(:item) { Item.create! name: "Charizard", price: "10.3", category_id: category.id, user_id: 1}
    before do
      put "/items/#{item.id}", params: { item: { name: "Venusaur", price: "8.3", category_id: category.id, description: "grass"}}
    end
    it "update an item" do
      expect(response).to have_http_status(:success)
    end
    it 'returns updated item\'s name' do
      expect(JSON.parse(response.body)['name']).to eq('Venusaur')
    end
  end

  describe "GET /items/:id" do
    let!(:category) { Category.create! name: 'foo'}
    let!(:item) { Item.create! name: "Charizard", price: "10.3", category_id: category.id, user_id: 1}
    before do
      get "/items/#{item.id}"
    end
    it "show an item" do
      expect(response).to have_http_status(:success)
    end
    it 'returns the item\'s id' do
      expect(JSON.parse(response.body)['name']).to eq('Charizard')
    end
  end

  describe "DELETE /items/:id" do
    let!(:category) { Category.create! name: 'foo'}
    let!(:item) { Item.create! name: "Charizard", price: "10.3", category_id: category.id, user_id: 1}

    it "delete an item" do
      expect {
        delete "/items/#{item.id}"
      }.to change { Item.count }.by(-1)

      expect(response).to have_http_status :no_content
    end
  end  
end
