require "application_system_test_case"

class AddCoachApplicationTest < ApplicationSystemTestCase
  setup do
    @event = create(:event, name: "Workshop Code Curious")
    @user = create(:user, email: "test@coach.de", password: "password")
    @coach = create(:coach, user: @user, gender: "female")

    visit coaches_sign_in_path

    fill_in "Email", with: "test@coach.de"
    fill_in "Password", with: "password"

    click_on "Sign in"
    click_on "Events"
    click_on "Workshop Code Curious"
  end

  test "Coach application" do
    check "installation get-together"
    check "workshop day"
    check "Yes, I'm coaching for the first time."
    check "Yes, I will attend the coach-the-coaches workshop."

    fill_in "coach_application_lightningtalk", with: "Yes"
    fill_in "coach_application_notes", with: "I'm happy"
    fill_in "coach_application_sponsor", with: "Yes"

    click_on "Submit"

    assert_text "Thank you for registering"

    coach_application = CoachApplication.last

    assert_equal coach_application.installationparty, true
    assert_equal coach_application.workshopday, true
    assert_equal coach_application.lightningtalk, "Yes"
    assert_equal coach_application.notes, "I'm happy"
    assert_equal coach_application.first_time_coaching, true
    assert_equal coach_application.coach_the_coaches, true
    assert_equal coach_application.sponsor, "Yes"
  end
end
