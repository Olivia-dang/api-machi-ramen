class User < ApplicationRecord

  devise  :database_authenticatable,
          :jwt_authenticatable,
          :registerable, :trackable,
          jwt_revocation_strategy: JwtDenylist
  has_many :items, dependent: :destroy

  before_save :assign_role

  def assign_role
    self.role = 'Regular' if role.nil?
  end

  def admin?
    self.role == "Admin"
  end

end
