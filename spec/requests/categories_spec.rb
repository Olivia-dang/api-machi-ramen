require 'rails_helper'

RSpec.describe "Categories", type: :request do
  # describe "GET /categories" do
  #   before do
  #     get "/categories"
  #   end
  #   it "returns http success" do
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "POST /categories" do  
  #   it "creates a new category" do
  #     post "/categories", params: { category: { name: "foo"}}
  #     expect(response).to have_http_status :created
  #   end
  # end

  # describe "PUT /categories/:id" do
  #   let!(:category) { Category.create! name: 'foo'}
  #   it "update a category" do
  #     put "/categories/#{category.id}", params: { category: { name: "grass"}}
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /categories/:id" do
  #   let!(:category) { Category.create! name: 'foo'}
  #   it "show a category" do
  #     get "/categories/#{category.id}"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "DELETE /categories/:id" do
  #   let!(:category) { Category.create! name: 'foo'}
  #   it "delete a category" do
  #     expect {
  #       delete "/categories/#{category.id}"
  #     }.to change { Category.count }.by(-1)

  #     expect(response).to have_http_status :no_content
  #   end
  # end  
end
