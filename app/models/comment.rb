class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true
  validates :date, presence: true
end
