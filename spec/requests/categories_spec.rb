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
