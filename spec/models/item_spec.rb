require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to be_a_kind_of(Item) }
  describe "attributes" do
    it { is_expected.to respond_to :name }
    it { should respond_to :price }
    it { should respond_to :description }
  end
end
