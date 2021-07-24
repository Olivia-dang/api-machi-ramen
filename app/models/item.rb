class Item < ApplicationRecord
  # get access to Rails’ url_helpers
  include Rails.application.routes.url_helpers

  belongs_to :category
  belongs_to :user
  validates :name, presence: true, length: { minimum: 3 }
  validates_numericality_of :price, :greater_than => 0

  has_one_attached :image

  # validates :image, {
  #   presence: true
  # }

  # To access the URL that ActiveStorage creates for each image
  def get_image_url
    url_for(self.image)
  end

end
