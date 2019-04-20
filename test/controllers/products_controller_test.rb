require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { is_hot: @product.is_hot, price_normal: @product.price_normal, price_sale_off: @product.price_sale_off, product_details: @product.product_details, product_image: @product.product_image, product_name: @product.product_name, product_sale_off: @product.product_sale_off, quantity: @product.quantity } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { is_hot: @product.is_hot, price_normal: @product.price_normal, price_sale_off: @product.price_sale_off, product_details: @product.product_details, product_image: @product.product_image, product_name: @product.product_name, product_sale_off: @product.product_sale_off, quantity: @product.quantity } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
