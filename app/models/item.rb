class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  validates :name, presence: true, length: { minimum: 3 }
  validates :price, presence: true
end
