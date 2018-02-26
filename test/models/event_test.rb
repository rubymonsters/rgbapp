require 'test_helper'

class EventTest < ActiveSupport::TestCase
  include Capybara::Email::DSL

  test "send reminders to selected and confirmed participants" do
    event = create(:event, scheduled_at: 2.days.from_now)
    applicant = create(:application, event: event, selected: true, attendance_confirmed: true)

    Event.send_reminders

    open_email(applicant.email)
    assert current_email.has_content?("Our workshop will take place on")
  end

  test "reminders not sent if event later than 2 days from now" do
    event = create(:event, scheduled_at: 3.days.from_now)
    applicant = create(:application, event: event, selected: true, attendance_confirmed: true)

    Event.send_reminders

    open_email(applicant.email)
    assert_nil(current_email)
  end

  test "reminders not sent if event is tomorrow" do
    event = create(:event, scheduled_at: 1.day.from_now)
    applicant = create(:application, event: event, selected: true, attendance_confirmed: true)

    Event.send_reminders

    open_email(applicant.email)
    assert_nil(current_email)
  end

  test "reminders not sent if applicant not selected" do
    event = create(:event, scheduled_at: 2.days.from_now)
    applicant = create(:application, event: event, selected: false, attendance_confirmed: true)

    Event.send_reminders

    open_email(applicant.email)
    assert_nil(current_email)
  end

  test "reminders not sent if applicant not confirmed" do
    event = create(:event, scheduled_at: 2.days.from_now)
    applicant = create(:application, event: event, selected: true, attendance_confirmed: false)

    Event.send_reminders

    open_email(applicant.email)
    assert_nil(current_email)
  end

end
