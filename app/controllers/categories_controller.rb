class CategoriesController < ApplicationController

  before_action :load_category, only: :index

  def index
    if params[:is_hot].present?
      @products = Product.get_all_hot_products
        .paginate page: params[:page],
        per_page: Settings.client.number_product
    else
      if !@category.sub_categories.present?
        @products = Product.get_products_by_category(params[:category_id])
          .paginate page: params[:page],
          per_page: Settings.client.number_product
      else
        #list_category_id = Category.get_list_sub_id(params[:category_id])
        @products = Product.get_products_by_category(@category.sub_categories.first.id)
          .paginate page: params[:page],
          per_page: Settings.client.number_product
      end
    end
    if @products.size <= Settings.client.number_invalid
      redirect_to root_path
      flash[:warning] = I18n.t "controller.product.no_product"
    end
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
  end

end
