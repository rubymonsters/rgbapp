require "application_system_test_case"

class AddEventTest < ApplicationSystemTestCase

  setup do
    create(:user, email: "test@user.de", password: "test", admin: true)

    visit admin_events_path

    fill_in "Email", with: "test@user.de"
    fill_in "Password", with: "test"

    click_on "Sign in"

    click_on "Add event"
  end

  test "Adding event" do

    fill_in "Name", with: "New event"
    fill_in "Place", with: "New venue"
    fill_in "Workshop date", with: "2018-05-25"
    fill_in "Workshop starts at", with: "09:00"
    fill_in "Workshop ends at", with: "18:00"
    fill_in "Applications start on", with: "2018-05-10"
    fill_in "Applications end on", with: "2018-05-15"
    fill_in "Attendance to be confirmed by", with: "2018-05-20"

    click_on "Save"

    assert_text "Here is a list of our workshops"
    assert_text "New event"
  end

  test "Adding event without filling in fields" do

    click_on "Save"

    assert_text "can't be blank"
  end
end
