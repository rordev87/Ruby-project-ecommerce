class Suggestion < ApplicationRecord
  belongs_to :user

  validates :category_name, presence: true
  validates :product_name, presence: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :description, presence: true
  validates :image, presence: true
end
