class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise  :database_authenticatable,
          :jwt_authenticatable,
          :registerable,
          jwt_revocation_strategy: self
  belongs_to :role, optional: true
  has_many :items, dependent: :destroy

  before_save :assign_role

  def assign_role
    self.role = Role.find_by name: 'Regular' if role.nil?
  end

end
