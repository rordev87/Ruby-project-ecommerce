module SessionCarts

  def init_session
    session[:cart] ||= []
  end

  def get_size_cart
    session[:cart].present? ? session[:cart].size : Settings.server.min_size
  end

  def get_orders
    session[:cart].present? ? session[:cart] : []
  end

  def get_list_ids
    ids = []
    session[:cart].each do |product|
      ids << product["product_id"]
    end
    ids
  end

  def get_list_product_id
    get_orders.present? ? get_list_ids : []
  end

  def get_quanlity product_id
    index_product_id = get_index_product_id(get_orders, product_id)
    if index_product_id.blank?
      Settings.server.min_quanlity
    else
      session[:cart][index_product_id]["quanlity"]
    end
  end

  def get_total_payment
    if session[:cart].present?
      get_total(get_orders)
    else
      Settings.server.min_payment
    end
  end

  def get_total orders
    total = Settings.server.min_payment
    orders.each do |product|
      total += get_price(product["product_id"], product["quanlity"])
    end
    total
  end

  def get_price id, quanlity
    Product.get_total_price(id, quanlity)
  end

  def add_order product
    session[:cart] << product
  end

  def add_quanlity index, product
    session[:cart][index]["quanlity"] += product[:quanlity]
  end

  def update_quanlity index, product
    session[:cart][index]["quanlity"] = product[:quanlity]
  end

  def get_index_product_id orders, product_id
    orders.find_index{|o| o["product_id"] == product_id}
  end

  def get_list_products
    ids = get_list_product_id
    if ids.present?
      @products = Product.get_product_by_ids(ids)
      if @products.blank?
        redirect_to root_path
        flash[:warning] = t "layouts.carts.no_cart"
      end
    else
      redirect_to root_path
      flash[:warning] = t "layouts.carts.no_cart"
    end
  end

  def add_product_into_cart orders, product
    product_id = product[:product_id]
    index_product_id = get_index_product_id(orders, product_id)
    if index_product_id.blank?
      add_order(product)
    else
      add_quanlity(index_product_id, product)
    end
  end

  def delete_product index
    session[:cart].delete_at(index)
  end

  def update_product_in_cart orders, product
    result = true
    product_id = product[:product_id]
    index_product_id = get_index_product_id(orders, product_id)
    if index_product_id.blank?
      result = false
    else
      update_quanlity(index_product_id, product)
    end
    result
  end

  def delete_product_in_cart orders, product_id
    result = true
    index_product_id = get_index_product_id(orders, product_id)
    if index_product_id.blank?
      result = false
    else
      delete_product(index_product_id)
    end
    result
  end
end
