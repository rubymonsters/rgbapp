require "application_system_test_case"

class SelectCoachesTest < ApplicationSystemTestCase
  setup do
    @event = create(:event, place: "Cool Office", start_time: "09:00", end_time: "17:30", coach_approval_mail_subject: "You are approved",
      coach_approval_mail: "Welcome {{ coach_name }} to the workshop on {{ event_date }} at {{ event_place }}")
    @admin = create(:user, email: "test@user.de", password: "test", admin: true)
    @user1 = create(:user, email: "user1@coach.de", password: "password")
    @user2 = create(:user, email: "user2@coach.de", password: "password")
    @coach1 = create(:coach, user: @user1, name: "Supercoach", gender: "female")
    @coach2 = create(:coach, user: @user2, gender: "female")
    @coach_application1 = create(:coach_application, event: @event, coach: @coach1, lightningtalk: "Amazing talk")
    @coach_application2 = create(:coach_application, event: @event, coach: @coach2)

    visit admin_event_coach_applications_path(@event.id)

    fill_in "Email", with: "test@user.de"
    fill_in "Password", with: "test"

    click_on "Sign in"
  end

  test "Approve coaches" do
    assert has_no_css?("#lightningtalk_approved_#{@coach_application2.id}")

    select("Approved", from: "state_#{@coach_application1.id}")
    select("Rejected", from: "state_#{@coach_application2.id}")

    check("lightningtalk_approved_#{@coach_application1.id}")

    click_on "Save"

    assert_text "Cool! Changes saved."

    assert @coach_application1.reload.approved?
    assert @coach_application2.reload.rejected?

    assert @coach_application1.lightningtalk_approved == true

    select("Rejected", from: "state_#{@coach_application1.id}")

    click_on "Save"

    assert_text "Cool! Changes saved."

    assert @coach_application1.reload.rejected?
  end

  test "Send approval e-mail" do
    select("Approved", from: "state_#{@coach_application1.id}")

    click_on "Save"

    clear_emails

    perform_enqueued_jobs do
      click_on "Send 1 e-mail"
    end

    open_email(@coach_application1.coach.user.email)

    assert_equal current_email.subject, "You are approved"
    assert current_email.has_content?("Welcome Supercoach to the workshop")
    assert current_email.has_content?("on #{@event.scheduled_at.strftime("%d.%m.%Y")}")
    assert current_email.has_content?("at Cool Office")
  end
end
