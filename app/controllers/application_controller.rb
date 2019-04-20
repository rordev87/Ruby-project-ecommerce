class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include SessionCarts
  $nav_categories = Category.get_root_categories

  helper_method :recent_products, :get_size_cart, :get_total_payment,
    :get_quanlity, :get_price

  def recent_products
    @recent_products ||= RecentProducts.new cookies
  end

end
