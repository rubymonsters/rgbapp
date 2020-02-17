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
    check "installation party"
    check "workshop day"

    fill_in "coach_application_lightningtalk", with: "Yes"
    fill_in "coach_application_notes", with: "I'm happy"

    click_on "Submit"

    assert_text "Thank you for registering"

    coach_application = CoachApplication.last

    assert_equal coach_application.installationparty, true
    assert_equal coach_application.workshopday, true
    assert_equal coach_application.lightningtalk, "Yes"
    assert_equal coach_application.notes, "I'm happy"
  end
end
