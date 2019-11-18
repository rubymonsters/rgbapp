require "application_system_test_case"

class CreateCoachTest < ApplicationSystemTestCase
  test "registration" do
    visit "/coaches/new"

    fill_in "E-mail address", with: "test@coach.de"
    fill_in "Password", with: "password"
    fill_in "Name", with: "Super coach"
    check "female/I have some female sex characteristics."
    check "English"
    check "Notifications about upcoming events"

    click_on "Submit"

    coach = Coach.last

    assert_equal coach.name, "Super coach"
    assert_equal coach.user.email, "test@coach.de"
    assert_equal coach.female, true
    assert_equal coach.language_en, true
    assert_equal coach.language_de, false
    assert_equal coach.notifications, true

  end
end
