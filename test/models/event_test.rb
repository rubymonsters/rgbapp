require 'test_helper'

class EventTest < ActiveSupport::TestCase
  include Capybara::Email::DSL

  test "send reminders to selected and confirmed participants" do
    event = create(:event, scheduled_at: 2.days.from_now)
    applicant = create(:application, event: event, state: :application_selected, attendance_confirmed: true)

    Event.send_reminders

    open_email(applicant.email)
    assert current_email.has_content?("Our workshop will take place on")
  end

  test "reminders not sent if event later than 2 days from now" do
    event = create(:event, scheduled_at: 3.days.from_now)
    applicant = create(:application, event: event, state: :application_selected, attendance_confirmed: true)

    Event.send_reminders

    open_email(applicant.email)
    assert_nil(current_email)
  end

  test "reminders not sent if event is tomorrow" do
    event = create(:event, scheduled_at: 1.day.from_now)
    applicant = create(:application, event: event, state: :application_selected, attendance_confirmed: true)

    Event.send_reminders

    open_email(applicant.email)
    assert_nil(current_email)
  end

  test "reminders not sent if applicant not selected" do
    event = create(:event, scheduled_at: 2.days.from_now)
    applicant1 = create(:application, event: event, state: :rejected, attendance_confirmed: true)
    applicant2 = create(:application, event: event, state: :waiting_list, attendance_confirmed: true)

    Event.send_reminders

    open_email(applicant1.email)
    assert_nil(current_email)
    
    open_email(applicant2.email)
    assert_nil(current_email)
  end

  test "reminders not sent if applicant not confirmed" do
    event = create(:event, scheduled_at: 2.days.from_now)
    applicant = create(:application, event: event, state: :application_selected, attendance_confirmed: false)

    Event.send_reminders

    open_email(applicant.email)
    assert_nil(current_email)
  end

  test "application start after scheduled at" do
    event = build(:event, scheduled_at: "2018-04-25", application_start: "2018-04-26", application_end: "2018-04-17", confirmation_date: "2018-04-20")
    assert event.invalid?
  end

  test "application end after scheduled at" do
    event = build(:event, scheduled_at: "2018-04-25", application_start: "2018-04-11", application_end: "2018-04-26", confirmation_date: "2018-04-20")
    assert event.invalid?
  end

  test "confirmation date before application end" do
    event = build(:event, scheduled_at: "2018-04-25", application_start: "2018-04-11", application_end: "2018-04-20", confirmation_date: "2018-04-17")
    assert event.invalid?
  end
end
