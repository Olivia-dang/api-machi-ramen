require 'rails_helper'

RSpec.describe User, type: :model do
    it { is_expected.to be_a_kind_of(User) }
  describe "attributes" do
    it { is_expected.to respond_to :email }
    it { should respond_to :first_name }
    it { should respond_to :last_name }
    it { should respond_to :phone_number }
  end
end
