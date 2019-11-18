require "application_system_test_case"

class SelectCoachesTest < ApplicationSystemTestCase
  setup do
    @event = create(:event, start_time: "09:00", end_time: "17:30")
    @admin = create(:user, email: "test@user.de", password: "test", admin: true)
    @user1 = create(:user, email: "user1@coach.de", password: "password")
    @user2 = create(:user, email: "user2@coach.de", password: "password")
    @coach1 = create(:coach, user: @user1)
    @coach2 = create(:coach, user: @user2)
    @coach_application1 = create(:coach_application, event: @event, coach: @coach1)
    @coach_application2 = create(:coach_application, event: @event, coach: @coach2)

    visit admin_event_coach_applications_path(@event.id)

    fill_in "Email", with: "test@user.de"
    fill_in "Password", with: "test"

    click_on "Sign in"
  end

  test "Approve coaches" do
    select("Approved", from: "state_#{@coach_application1.id}")
    select("Rejected", from: "state_#{@coach_application2.id}")

    click_on "Save"

    assert_text "Cool! Changes saved."

    assert @coach_application1.reload.approved?
    assert @coach_application2.reload.rejected?

    select("Rejected", from: "state_#{@coach_application1.id}")

    click_on "Save"

    assert_text "Cool! Changes saved."

    assert @coach_application1.reload.rejected?
  end
end
