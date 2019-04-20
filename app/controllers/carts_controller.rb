class CartsController < ApplicationController

  def index
    get_list_products
  end

  def create
    init_session
    product_id = params[:product_id].to_i
    quanlity = params[:quanlity].to_i
    product = {product_id: product_id, quanlity: quanlity}
    add_product_into_cart(get_orders, product)
  end

  def update
    product_id = params[:product_id].to_i
    quanlity = params[:quanlity].to_i
    product = {product_id: product_id, quanlity: quanlity}
    if !update_product_in_cart(get_orders, product)
      flash[:warning] = t "layouts.carts.update_failed"
      redirect_to carts_path
    end
    get_list_products
  end

  def show
  end

  def destroy
    product_id = params[:product_id].to_i
    if delete_product_in_cart(get_orders, product_id)
      flash[:success] = t "layouts.carts.deleted"
    else
      flash[:warning] = t "layouts.carts.delete_failed"
    end
    redirect_to carts_path
  end

end
