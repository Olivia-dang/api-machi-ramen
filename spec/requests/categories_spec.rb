require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /categories" do
    before do
      get "/categories"
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  context "When user's role is not admin" do
    before do
      sign_in create(:user, email: "test@test.com", password: "iamhungry", id:5, role: "Regular")
    end
    it "they cannot create a new menu category" do
      post "/categories", params: { category: { name: "Hello"}}
      expect(response).to have_http_status :unauthorized
    end
    let!(:category) { Category.create! name: "Charmander"}
    it "they cannot update a new menu category" do
      put "/categories/#{category.id}", params: { category: { name: "Venusaur"}}
      expect(response).to have_http_status :unauthorized
    end
    it "they cannot delete a category" do
      delete "/categories/#{category.id}"
      expect(response).to have_http_status :unauthorized
    end
  end

  before do
    sign_in create(:user, email: "admin@test.com", password: "iamhungry", id:1, role: "Admin")
  end

  describe "POST /categories" do
    before do
      post "/categories", params: { category: { name: "Fire"}}
    end
    it "creates a new category" do
      expect(response).to have_http_status :created
    end
    it 'returns the category\'s id' do
      expect(JSON.parse(response.body)['name']).to eq('Fire')
    end
  end

  context "When new category name is less than 3 characters" do
    before do
      post "/categories", params: { category: { name: "Hi"}}
    end
    it "returns 422 Unprocessable Entity" do
      expect(response.status).to eq(422)
    end
    it 'returns 422 error message' do
      expect(JSON.parse(response.body)['name']).to eq(["is too short (minimum is 3 characters)"])
    end
  end

  context "When category id cannot be found" do
    it "returns 404 Not Found" do
      get "/categories/5000"
      expect(response.status).to eq(404)
    end
  end

  describe "PUT /categories/:id" do
    let!(:category) { Category.create! name: 'foo'}
    before do
      put "/categories/#{category.id}", params: { category: { name: "Grass"}}
    end
    it "update a category" do
      expect(response).to have_http_status(:success)
    end
    it 'returns updated category\'s name' do
      expect(JSON.parse(response.body)['name']).to eq('Grass')
    end
  end

  describe "GET /categories/:id" do
    let!(:category) { Category.create! name: 'foo'}
    before do
      get "/categories/#{category.id}"
    end
    it "show a category" do
      expect(response).to have_http_status(:success)
    end
    it 'returns the category\'s id' do
      expect(JSON.parse(response.body)['name']).to eq('foo')
    end
  end

  describe "DELETE /categories/:id" do
    let!(:category) { Category.create! name: 'foo'}

    it "delete an category" do
      expect {
        delete "/categories/#{category.id}"
      }.to change { Category.count }.by(-1)

      expect(response).to have_http_status :no_content
    end
  end  
end
