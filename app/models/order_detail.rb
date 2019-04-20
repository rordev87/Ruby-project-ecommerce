class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates_uniqueness_of :order_id, scope: :product_id
  validates :quanlity, presence: true, numericality: {greater_than: 0}
  validates :total_price, presence: true, numericality: {greater_than: 0}
end
