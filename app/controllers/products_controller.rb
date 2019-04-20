class ProductsController < ApplicationController

  before_action :load_product, only: :show

  def index
    case params[:subsearch]
    when I18n.t("layouts.header.search")
      search
    when I18n.t("product.index.sort")
      filter
    else
      view_recents
    end
  end

  def show
    if !@product.nil?
      @avg_rating = @product.average_rating
      @count_rating = Rating.get_count_rating(params[:id])
      recent_products.push @product #ham show duoc goi thi day id vao cookies
    else
      redirect_to root_path
      flash[:warning] = I18n.t "controller.product.no_product"
    end
  end

  private
  def view_recents
    @products = Product.get_product_by_ids(recent_products)
      .paginate page: params[:page], per_page: Settings.client.number_product
    if @products.size > Settings.client.number_invalid
      render :index
    else
      redirect_to root_path
      flash[:warning] = I18n.t "controller.product.no_product"
    end
  end

  def search
    if params[:search].present?
      @products = Product.get_products_by_name(params[:search])
        .paginate page: params[:page], per_page: Settings.client.number_product
    else
      @products = Product.all.paginate page: params[:page],
        per_page: Settings.client.number_product
    end
    if @products.size <= Settings.client.number_invalid
      redirect_to root_path
      flash[:warning] = I18n.t "controller.product.no_product"
    end
  end

  def filter
    if params[:category_id].present?
	  @category = Category.find_by id: params[:category_id]
         list_sub_id=[]
         Category.all.each do |category|
         if (category.parent_id==@category.id) then list_sub_id<<category.id
		 end
         end
      @products = Product.filter_category(list_sub_id)
        .paginate page: params[:page], per_page: Settings.client.number_product
      if params[:price] && params[:price] != Product::PRICE.first
        if params[:price] == Product::PRICE.last
          min_price = params[:price].split(">").last.to_i
          @products = @products.filter_price_min(min_price)
            .paginate page: params[:page],
            per_page: Settings.client.number_product
        else
          min_price = params[:price].split("-").first.to_i
          max_price = params[:price].split("-").last.to_i
          price = (min_price..max_price)
          @products = @products.filter_price_range(price)
            .paginate page: params[:page],
            per_page: Settings.client.number_product
        end
      end
      if params[:rating] && params[:rating] != Product::RATING.first
        min_rating = params[:rating].split("-").first.to_i
        max_rating = params[:rating].split("-").last.to_i
        list_product_id = Rating.get_list_product_id(min_rating, max_rating)
        @products = @products.filter_rating_range(list_product_id)
          .paginate page: params[:page],
          per_page: Settings.client.number_product
      end
      if params[:order] && params[:order] != Product::ORDER.first
        if params[:option] == Product::OPTION.first
          sort = "ASC"
        else
          sort = "DESC"
        end
        if params[:order] == Product::ORDER.second
          @products = @products.filter_name_order(sort)
            .paginate page: params[:page],
            per_page: Settings.client.number_product
        elsif params[:order] == Product::ORDER.last
          @products = @products.filter_price_order(sort)
            .paginate page: params[:page],
            per_page: Settings.client.number_product
        end
      end
      if @products.size <= Settings.client.number_invalid
        redirect_to root_path
        flash[:warning] = I18n.t "controller.product.no_product"
      end
    end
  end

  private
  def load_product
    @product = Product.find_by id: params[:id]
  end

end
