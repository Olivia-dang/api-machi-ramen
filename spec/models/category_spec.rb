require 'rails_helper'

RSpec.describe Category, type: :model do
  it "should be a Category" do
    expect(subject).to be_a_kind_of(Category)
  end
  describe "attributes" do
    it "should respond to #name" do
      expect(subject).to respond_to :name
    end
  end
end
