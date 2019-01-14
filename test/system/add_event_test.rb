require "application_system_test_case"

class AddEventTest < ApplicationSystemTestCase

  setup do
    create(:user, email: "test@user.de", password: "test", admin: true)
    create(:event, name: "previous event", scheduled_at: "2017-04-20", application_start: "2017-04-01", application_end: "2017-04-10", confirmation_date: "2017-04-15", selection_mail: "You have been selected.", selection_mail_subject: "Congratulations!")

    visit admin_events_path

    fill_in "Email", with: "test@user.de"
    fill_in "Password", with: "test"

    click_on "Sign in"

    click_on "Add event"
  end

  test "Adding event with email template" do

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
    select "2017-04-20 previous event", from: "event_copy_templates_from_event_id"

    click_on "Save"

    assert_equal Event.last.name, "New event"
    assert_equal Event.last.selection_mail_subject, "Congratulations!"
    assert_equal Event.last.selection_mail, "You have been selected."
  end

  test "Adding event without email template" do

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

    click_on "Selection e-mail"

    assert_nil Event.last.selection_mail
  end

  test "Adding event without filling in fields" do

    click_on "Save"

    assert_text "can't be blank"
  end
end
