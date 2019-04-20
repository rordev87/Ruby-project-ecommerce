require 'test_helper'

class CaterogisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @caterogi = caterogis(:one)
  end

  test "should get index" do
    get caterogis_url
    assert_response :success
  end

  test "should get new" do
    get new_caterogi_url
    assert_response :success
  end

  test "should create caterogi" do
    assert_difference('Caterogi.count') do
      post caterogis_url, params: { caterogi: { description: @caterogi.description, name: @caterogi.name, parent_id: @caterogi.parent_id } }
    end

    assert_redirected_to caterogi_url(Caterogi.last)
  end

  test "should show caterogi" do
    get caterogi_url(@caterogi)
    assert_response :success
  end

  test "should get edit" do
    get edit_caterogi_url(@caterogi)
    assert_response :success
  end

  test "should update caterogi" do
    patch caterogi_url(@caterogi), params: { caterogi: { description: @caterogi.description, name: @caterogi.name, parent_id: @caterogi.parent_id } }
    assert_redirected_to caterogi_url(@caterogi)
  end

  test "should destroy caterogi" do
    assert_difference('Caterogi.count', -1) do
      delete caterogi_url(@caterogi)
    end

    assert_redirected_to caterogis_url
  end
end
