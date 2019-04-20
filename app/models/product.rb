class Product < ApplicationRecord

  HOT = ["Normal", "Hot"]
  OPTION = ["Ascending", "Decrease"]
  PRICE = ["None", "1-300000", "300000-500000", "500000-1000000", ">1000000"]
  RATING = ["None", "0-3", "4-6", "7-10"]
  ORDER = ["None", "Alphalbet", "Price"]

  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :category
  validates :product_name, presence: true,
    uniqueness: {case_sensitive: false}
  validates :product_image, presence: true
  validates :product_details, presence: true
  validates :product_sale_off, inclusion: {in: [true, false]}
  validates :price_normal, presence: true, numericality: {greater_than: 0}
  validates :price_sale_off, numericality: {greater_than_or_equal_to: 0},
    allow_nil: true
  validates :is_hot, inclusion: {in: [true, false]}
  validates :quanlity, presence: true,
    numericality: {greater_than_or_equal_to: 0}

  scope :get_limit_products, -> category_id do
    where(category_id: Category.get_child_category(category_id))
      .limit(Settings.client.limit_view)
  end
  scope :get_product_by_ids, -> ids do
    where(id: ids)
  end
  scope :get_products_by_category, -> category do
    where(category_id: category)
  end
  scope :get_products_by_name, -> product_name do
    where("product_name LIKE ?", "%#{product_name}%")
  end
  scope :filter_category, -> category_id do
    where(category_id: category_id)
  end
  scope :filter_price_min, -> min_price do
    where("price_normal >= ?", min_price)
  end
  scope :filter_price_range, -> price do
    where(price_normal: price)
  end
  scope :filter_rating_range, -> list_ids do
    where(id: list_ids)
  end
  scope :filter_name_order, -> sort do
    order("product_name " + sort)
  end
  scope :filter_price_order, -> sort do
    order("price_normal " + sort)
  end

  scope :get_all_hot_products, -> do
    ids_hot = Rating.select("product_id, AVG(rate) as avg")
      .group("product_id").having("avg > 7")
      .order("avg ASC").map(&:product_id)
    products = Product.where(id: ids_hot)
  end

  def self.get_hot_products
    products = get_all_hot_products.limit(Settings.client.limit_view)
  end

  def self.get_total_price id, quanlity
    product = Product.find_by id: id
    if product
      product.price_normal * quanlity
    else
      Settings.server.min_payment
    end
  end

  def average_rating
    if ratings.size > Settings.server.min_size
      ratings.sum(:rate) / ratings.size
    else
      return Settings.server.min_average
    end
  end

end
