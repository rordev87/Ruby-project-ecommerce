require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Activated", with: @user.activated
    fill_in "Activated at", with: @user.activated_at
    fill_in "Activation digest", with: @user.activation_digest
    fill_in "Address", with: @user.address
    fill_in "Avater", with: @user.avater
    fill_in "Date of birth", with: @user.date_of_birth
    fill_in "Email", with: @user.email
    fill_in "Is admin", with: @user.is_admin
    fill_in "Password digest", with: @user.password_digest
    fill_in "Remember digest", with: @user.remember_digest
    fill_in "User name", with: @user.user_name
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Activated", with: @user.activated
    fill_in "Activated at", with: @user.activated_at
    fill_in "Activation digest", with: @user.activation_digest
    fill_in "Address", with: @user.address
    fill_in "Avater", with: @user.avater
    fill_in "Date of birth", with: @user.date_of_birth
    fill_in "Email", with: @user.email
    fill_in "Is admin", with: @user.is_admin
    fill_in "Password digest", with: @user.password_digest
    fill_in "Remember digest", with: @user.remember_digest
    fill_in "User name", with: @user.user_name
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
