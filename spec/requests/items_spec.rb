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

  describe "POST /items" do
    let!(:category) { Category.create! name: 'foo'}
    
    it "creates a new item" do
      post "/items", params: { item: { name: "Charizard", price: "10.3", category_id: category.id}}
      expect(response).to have_http_status :created
    end
  end

  describe "PUT /items/:id" do
    let!(:category) { Category.create! name: 'foo'}
    let!(:item) { Item.create! name: "Charizard", price: "10.3", category_id: category.id}
    it "update an item" do
      put "/items/#{item.id}", params: { item: { name: "Venusaur", price: "8.3", category_id: category.id, description: "grass"}}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /items/:id" do
    let!(:category) { Category.create! name: 'foo'}
    let!(:item) { Item.create! name: "Charizard", price: "10.3", category_id: category.id}
    it "show an item" do
      get "/items/#{item.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /items/:id" do
    let!(:category) { Category.create! name: 'foo'}
    let!(:item) { Item.create! name: "Charizard", price: "10.3", category_id: category.id}
    it "delete an item" do
      expect {
        delete "/items/#{item.id}"
      }.to change { Item.count }.by(-1)

      expect(response).to have_http_status :no_content
    end
  end  
end
