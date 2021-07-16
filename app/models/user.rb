class User < ApplicationRecord
  devise  :database_authenticatable,
          :jwt_authenticatable,
          :registerable,
          jwt_revocation_strategy: JwtDenylist
  belongs_to :role
  has_many :items, dependent: :destroy
  validates :first_name, presence: true

  before_save :assign_role

  def assign_role
    self.role = Role.find_by name: 'Regular' if role.nil?
  end
end
