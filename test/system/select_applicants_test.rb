require "application_system_test_case"

class SelectApplicantsTest < ApplicationSystemTestCase
  test "select applicant" do
    event = create(:event)
    user = create(:user, email: "test@user.de", password: "test", admin: true)
    #applicant1 = event.applications.create!(female: true, name: "Test Applicant1", email: "applicant1@test.de", level: "0", os: "Mac", language_en: true, read_coc: true)
    applicant1 = create(:application, event: event)
    applicant2 = create(:application, event: event)

    visit event_applications_path(event.id)

    fill_in "Email", with: "test@user.de"
    fill_in "Password", with: "test"

    click_on "Sign in"

    check("select_applicant_#{applicant1.id}")

    click_on "Save"

    assert_text "Cool! Changes saved."

    assert applicant1.reload.selected?
    assert !applicant2.reload.selected?

    uncheck("select_applicant_#{applicant1.id}")

    click_on "Save"

    assert_text "Cool! Changes saved."

    assert !applicant1.reload.selected?
    assert !applicant2.reload.selected?

  end
end
