require "application_system_test_case"

class CaterogisTest < ApplicationSystemTestCase
  setup do
    @caterogi = caterogis(:one)
  end

  test "visiting the index" do
    visit caterogis_url
    assert_selector "h1", text: "Caterogis"
  end

  test "creating a Caterogi" do
    visit caterogis_url
    click_on "New Caterogi"

    fill_in "Description", with: @caterogi.description
    fill_in "Name", with: @caterogi.name
    fill_in "Parent", with: @caterogi.parent_id
    click_on "Create Caterogi"

    assert_text "Caterogi was successfully created"
    click_on "Back"
  end

  test "updating a Caterogi" do
    visit caterogis_url
    click_on "Edit", match: :first

    fill_in "Description", with: @caterogi.description
    fill_in "Name", with: @caterogi.name
    fill_in "Parent", with: @caterogi.parent_id
    click_on "Update Caterogi"

    assert_text "Caterogi was successfully updated"
    click_on "Back"
  end

  test "destroying a Caterogi" do
    visit caterogis_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Caterogi was successfully destroyed"
  end
end
