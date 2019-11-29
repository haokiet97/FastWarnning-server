require "application_system_test_case"

class CamerasTest < ApplicationSystemTestCase
  setup do
    @camera = cameras(:one)
  end

  test "visiting the index" do
    visit cameras_url
    assert_selector "h1", text: "Cameras"
  end

  test "creating a Camera" do
    visit cameras_url
    click_on "New Camera"

    click_on "Create Camera"

    assert_text "Camera was successfully created"
    click_on "Back"
  end

  test "updating a Camera" do
    visit cameras_url
    click_on "Edit", match: :first

    click_on "Update Camera"

    assert_text "Camera was successfully updated"
    click_on "Back"
  end

  test "destroying a Camera" do
    visit cameras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Camera was successfully destroyed"
  end
end
