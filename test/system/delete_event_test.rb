require "application_system_test_case"

class DeleteEventTest < ApplicationSystemTestCase

  setup do
      create(:event, name: "Test Me")
      create(:user, email: "test@user.de", password: "test", admin: true)

      visit admin_events_path

      fill_in "Email", with: "test@user.de"
      fill_in "Password", with: "test"

      click_on "Sign in"
  end

  test "Deleting an event" do

    click_on "Test Me"

    click_on "Delete event"

    assert_text "Here is a list of our workshops"
    assert_no_text "Test Me"
  end
end
