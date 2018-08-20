require "application_system_test_case"

class SelectApplicantsTest < ApplicationSystemTestCase

  setup do
    clear_emails
    @event = create(:event, start_time: "09:00", end_time: "17:30", selection_mail: "Workshop Day: {{ event_date }} from 09:00 until 17:30 {{ confirmation_link }}", rejection_mail: "Sorry, you are rejected" )
    @user = create(:user, email: "test@user.de", password: "test", admin: true)
    @applicant1 = create(:application, event: @event)
    @applicant2 = create(:application, event: @event)

    visit admin_event_applications_path(@event.id)

    fill_in "Email", with: "test@user.de"
    fill_in "Password", with: "test"

    click_on "Sign in"
  end

  test "select or confirm applicant" do
    check("select_applicant_#{@applicant1.id}")
    check("confirm_applicant_#{@applicant2.id}")

    click_on "Save"

    assert_text "Cool! Changes saved."

    assert @applicant1.reload.selected?
    assert !@applicant2.reload.selected?

    assert !@applicant1.reload.attendance_confirmed?
    assert @applicant2.reload.attendance_confirmed?

    uncheck("select_applicant_#{@applicant1.id}")
    uncheck("confirm_applicant_#{@applicant2.id}")

    click_on "Save"

    assert_text "Cool! Changes saved."

    assert !@applicant1.reload.selected?
    assert !@applicant2.reload.selected?

    assert !@applicant1.reload.attendance_confirmed?
    assert !@applicant2.reload.attendance_confirmed?
  end

  test "complete selection" do
    @applicant1.update_attributes(selected: true)
    perform_enqueued_jobs do
      assert_no_text "The selection is completed"

      click_on "Selection complete"

      assert_text "The selection is completed"

      assert has_no_button?('Selection complete')
    end

    open_email(@applicant1.email)

    assert current_email.has_content?("/events/#{@event.id}/applications/#{@applicant1.random_id}/confirm")
    assert current_email.has_content?("Workshop Day: #{@event.scheduled_at.strftime("%d.%m.%Y")} from 09:00 until 17:30")

    open_email(@applicant2.email)
    assert current_email.has_content?("Sorry, you are rejected")

  end

  test "additional selection" do
    @applicant1.update_attributes(selected: true)

    perform_enqueued_jobs do
      click_on "Selection complete"
    end

    clear_emails

    check("select_applicant_#{@applicant2.id}")

    click_on "Save"

    perform_enqueued_jobs do
      click_on "Send e-mails"
    end

    open_email(@applicant2.email)

    assert current_email.has_content?("/events/#{@event.id}/applications/#{@applicant2.random_id}/confirm")
    assert current_email.has_content?("Workshop Day: #{@event.scheduled_at.strftime("%d.%m.%Y")} from 09:00 until 17:30")

    open_email(@applicant1.email)
    assert_nil current_email
  end
end
