class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates_uniqueness_of :user_id, scope: [:product_id]
  validates :rate, presence: true, inclusion: {in: 1..10}

  scope :get_average_rating, -> product_id do
    where(product_id: product_id).average(:rate)
  end
  scope :get_count_rating, -> product_id {where(product_id: product_id).size}
  scope :get_list_product_id, -> (min, max) do
    select(:product_id).group(:product_id)
    .having("AVG(rate) BETWEEN ? AND ?", min, max).pluck(:product_id)
  end

  def self.get_rating_record(user_id, product_id)
    self.find_by(user_id: user_id, product_id: product_id)
  end

end
