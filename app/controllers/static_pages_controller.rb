class StaticPagesController < ApplicationController
  def home
    @categories = Category.get_root_categories
    @hot_products = Product.get_hot_products
  end

  def help
  end

  def about
  end

  def contact
  end
end
