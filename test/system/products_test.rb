require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "creating a Product" do
    visit products_url
    click_on "New Product"

    fill_in "Is hot", with: @product.is_hot
    fill_in "Price normal", with: @product.price_normal
    fill_in "Price sale off", with: @product.price_sale_off
    fill_in "Product details", with: @product.product_details
    fill_in "Product image", with: @product.product_image
    fill_in "Product name", with: @product.product_name
    fill_in "Product sale off", with: @product.product_sale_off
    fill_in "Quantity", with: @product.quantity
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "updating a Product" do
    visit products_url
    click_on "Edit", match: :first

    fill_in "Is hot", with: @product.is_hot
    fill_in "Price normal", with: @product.price_normal
    fill_in "Price sale off", with: @product.price_sale_off
    fill_in "Product details", with: @product.product_details
    fill_in "Product image", with: @product.product_image
    fill_in "Product name", with: @product.product_name
    fill_in "Product sale off", with: @product.product_sale_off
    fill_in "Quantity", with: @product.quantity
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "destroying a Product" do
    visit products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product was successfully destroyed"
  end
end
