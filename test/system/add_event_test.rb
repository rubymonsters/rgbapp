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
    select "2018", from: "event_scheduled_at_1i"
    select "May", from: "event_scheduled_at_2i"
    select "25", from: "event_scheduled_at_3i"
    fill_in "Workshop starts at", with: "09:00"
    fill_in "Workshop ends at", with: "18:00"
    select "2018", from: "event_application_start_1i"
    select "May", from: "event_application_start_2i"
    select "10", from: "event_application_start_3i"
    select "2018", from: "event_application_end_1i"
    select "May", from: "event_application_end_2i"
    select "15", from: "event_application_end_3i"
    select "2018", from: "event_confirmation_date_1i"
    select "May", from: "event_confirmation_date_2i"
    select "20", from: "event_confirmation_date_3i"

    click_on "Save"

    assert_text "New event"
  end

  test "Adding event without filling in fields" do

    click_on "Save"

    assert_text "can't be blank"
  end
end
