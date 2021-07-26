require 'rails_helper'

RSpec.describe "Items", type: :request do
  let (:category) { FactoryBot.create(:category)}

  describe "GET /items" do
    before do
      get "/items"
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  context "When user's role is not admin" do
    before do
      sign_in create(:user, email: "test@test.com", password: "iamhungry", id:5, role: "Regular")
    end
    it "they cannot create a new menu item" do
      post "/items", params: { item: { name: "Charizard", price: "10.3", category_id: category.id, user_id: 1}}
      expect(response).to have_http_status :unauthorized
    end
    let!(:item) { Item.create! name: "Charmander", price: "87", category_id: category.id, user_id: 1}
    it "they cannot update a new menu item" do
      put "/items/#{item.id}", params: { item: { name: "Venusaur", price: "8.3", category_id: category.id, description: "grass"}}
      expect(response).to have_http_status :unauthorized
    end
    it "they cannot delete an item" do
      delete "/items/#{item.id}"
      expect(response).to have_http_status :unauthorized
    end
  end
  
  before do
    sign_in create(:user, email: "admin@test.com", password: "iamhungry", id:1, role: "Admin")
  end

  describe 'POST /create' do
    before do
      post "/items", params: {
        image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pikachu.png"),
        name: "Pikachu", 
        price: "10.3", 
        category_id: category.id, 
        user_id: 1
      }
    end
    it "creates a new item" do
      expect(response).to have_http_status :created
    end
    it 'returns the item\'s id' do
      expect(JSON.parse(response.body)['name']).to eq('Pikachu')
    end
    
  end

  context "When new item name is less than 3 characters" do
    before do
      post "/items", params: {
        image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pikachu.png"),
        name: "Pi", 
        price: "10.3", 
        category_id: category.id, 
        user_id: 1
      }
    end
    it "returns 422 Unprocessable Entity" do
      expect(response.status).to eq(422)
    end
    it 'returns 422 error message' do
      expect(JSON.parse(response.body)['name']).to eq(["is too short (minimum is 3 characters)"])
    end
  end

  context "When new item name price is not greater than 0" do
    it "returns 422 Unprocessable Entity" do
      post "/items", params: {
        image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pikachu.png"),
        name: "Pikachu", 
        price: 0, 
        category_id: category.id, 
        user_id: 1
      }
      expect(response.status).to eq(422)
    end
  end


  describe "PUT /items/:id" do
    let!(:item) { Item.create! name: "Charizard", price: "10.3", category_id: category.id, user_id: 1, image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pikachu.png")}
    before do
      put "/items/#{item.id}", params: {
        image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pikachu.png"),
        name: "Venusaur", 
        price: 90, 
        category_id: category.id, 
        user_id: 1
      }
    end
    it "update an item" do
      expect(response).to have_http_status(:success)
    end
    it 'returns updated item\'s name' do
      expect(JSON.parse(response.body)['name']).to eq('Venusaur')
    end
  end

  describe "GET /items/:id" do
    let!(:item) { Item.create! name: "Charizard", price: "10.3", category_id: category.id, user_id: 1, image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pikachu.png")}
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
  
  context "When item id cannot be found" do
    it "returns 404 Not Found" do
      get "/items/5000"
      expect(response.status).to eq(404)
    end
  end


  describe "DELETE /items/:id" do
    let!(:item) { Item.create! name: "Charizard", price: "10.3", category_id: category.id, user_id: 1, image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/pikachu.png")}

    it "delete an item" do
      expect {
        delete "/items/#{item.id}"
      }.to change { Item.count }.by(-1)

      expect(response).to have_http_status :no_content
    end
  end  
end
