require "application_system_test_case"

class EditEventTest < ApplicationSystemTestCase

  setup do
      create(:event, name: "Test Me")
      create(:user, email: "test@user.de", password: "test", admin: true)

      visit admin_events_path

      fill_in "Email", with: "test@user.de"
      fill_in "Password", with: "test"

      click_on "Sign in"

      click_on "Edit"
  end

  test "Editing event" do
    fill_in("Name", { currently_with: "Test Me", with: "Some Event" } )

    #save_and_open_page

    click_on "Save"

    assert_text "Some Event"
  end

  test "Making an invalid entry" do
    fill_in("Name", { currently_with: "Test Me", with: "" } )

    click_on "Save"

    assert_text "Name can't be blank"

    assert_equal Event.first.name, "Test Me"

    fill_in("Name", { currently_with: "", with: "Some Event" } )

    click_on "Save"

    assert_text "Some Event"
  end

end
