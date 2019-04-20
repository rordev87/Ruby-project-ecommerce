class OrdersController < ApplicationController

  before_action :load_order, only: [:update, :show, :destroy]
  before_action :load_orders, only: :index
  before_action :load_list_product, only: :new

  def new
    if logged_in?
      @order = Order.new
    else
      flash[:warning] = t "order.login"
      redirect_to login_path
    end
  end

  def index
  end

  def create
    @order = Order.new order_params
    products = get_orders
    result = false
    result1 = false
    if products.present?
      Order.transaction do
        result = @order.save
        result1 = save_order_details(products, @order.id)
        raise ActiveRecord::Rollback if result1 == false
      end
      if result && result1
        flash[:success] = t "order.create_success"
        session.delete(:cart)
        redirect_to orders_path(user_id: current_user.id)
      else
        get_list_products
        render :new
      end
    else
      flash[:warning] = t "order.order_not_found"
      redirect_to root_path
    end
  end

  def show
    if  @order.order_details.blank?
      flash[:warning] = t "order.order_not_found"
    end
  end

  def update
    if request.xhr?
      if admin?
        if params[:value]=="accept"
          @order.state = Order.types[:done]
          @order.save
          OrderMailer.confirm_order(User.find_by(id: @order.user_id),@order).deliver_now
          #update so luong product khi ma admin da duyet don hang
          @order.order_details.each do|order_detail|
          product=Product.find_by(id: order_detail.product_id)
          product.quanlity-=order_detail.quanlity
          product.save
         end
        elsif params[:value] == "deny"
          @order.state = Order.types[:cancel]
        end
        if @order.save
          flash[:success] = t "admin.updated"
          redirect_to orders_path
        else
          flash[:warning] = t "admin.update_failed"
          render :show
        end
      end
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t "order.delete_success"
      redirect_to orders_path
    else
      flash[:warning] = t "order.delete_failed"
      render :show
    end
  end

  private
  def load_list_product
    get_list_products
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return redirect_to(orders_path) if @order.nil?
  end

  def order_params
   params.require(:order).permit :user_id, :total_payment, :receiver,
      :receiving_address, :state, :note
  end

  def load_orders
    if admin?
      load_orders_for_admin
    else
      load_orders_for_user params[:user_id], Order.types[:waiting]
    end
    if @orders.blank?
      flash[:warning] = t "order.order_not_found"
      if admin?
        redirect_to orders_path
      else
        redirect_to root_path
      end
    end
  end

  def load_orders_for_admin
    @orders = Order.order(updated_at: :desc, state: :desc)
      .paginate page: params[:page], per_page: Settings.client.number_product
    if params[:order_search].present?
      @orders = Order.search_by_name(params[:order_search])
        .paginate page: params[:page], per_page: Settings.client.number_product
    end
    if params[:state].present?
      @orders = Order.search_by_state(params[:state])
        .paginate page: params[:page], per_page: Settings.client.number_product
    end
  end

  def load_orders_for_user user_id, type
    @orders = Order.get_orders(user_id, type)
      .paginate page: params[:page], per_page: Settings.client.number_product
  end

  def save_order_details products, order_id
    result = true
    OrderDetail.transaction do
      products.each do |product|
        order_detail = new_order_detail(product, order_id)
        if !order_detail.save
          result = false
        end
      end
    end
    result
  end

  def new_order_detail product, order_id
    quanlity = product["quanlity"]
    product_id = product["product_id"]
    total_price = get_price(product_id, quanlity)
    OrderDetail.new(quanlity: quanlity, total_price: total_price,
      order_id: order_id, product_id: product_id)
  end

end
