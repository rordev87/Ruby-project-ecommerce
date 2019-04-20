class Order < ApplicationRecord
  enum type: [ :processing, :done,:cancel]

  has_many :order_details, dependent: :destroy

  belongs_to :user

  validates :total_payment, presence: true,
    numericality: {greater_than_or_equal_to: 0}
  validates :state, presence: true, inclusion: {in: Order.types.values}
  validates :receiving_address, presence: true
  validates :receiver, presence: true

  scope :get_orders, -> (user_id, state) do
    where(user_id: user_id).where.not(state: state).order("updated_at DESC")
  end

  scope :search_by_name, -> user_name do
    Order.joins(:user).where("users.user_name LIKE '%#{user_name}%'")
  end

  scope :search_by_state, -> state do
    where(state: state).order("updated_at DESC")
  end

end
