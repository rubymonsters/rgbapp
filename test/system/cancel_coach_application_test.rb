require "application_system_test_case"

class CancelCoachApplicationTest < ApplicationSystemTestCase
  setup do
    @event = create(:event, name: "Workshop Code Curious")
    @user = create(:user, email: "test@coach.de", password: "password")
    @coach = create(:coach, user: @user, gender: "female")
    @coach_application = create(:coach_application, event: @event, coach: @coach, state: :pending)

    visit coaches_sign_in_path
    fill_in "Email", with: "test@coach.de"
    fill_in "Password", with: "password"

    click_on "Sign in"
    click_on "Events"
  end

  test "Cancel coach application" do
    click_on "Cancel"

    assert_text "Cancelled"
  end
end
