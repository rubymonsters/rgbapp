require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "Get an event that does not exist responds to 404" do
    assert_raises ActiveRecord::RecordNotFound do
      get "/events/5/applications/new"
    end
  end

  test "Get an event on the day the application period ends" do
    event = create(:event, name: "Test Me", place: "Testing", installation_get_together_date: 13.days.from_now, scheduled_at: 2.weeks.from_now, application_start: Date.yesterday, application_end: Date.today, confirmation_date: 12.days.from_now)
    get "/events/#{event.id}/applications/new"
    assert_response 200
    assert_select "h1", "Test Me #{I18n.l 13.days.from_now.to_date, format: :short} & #{I18n.l 2.weeks.from_now.to_date}"
  end

  test "Get an event on the day the application period starts" do
    event = create(:event, name: "Test Me", place: "Testing", installation_get_together_date: 13.days.from_now, scheduled_at: 2.weeks.from_now, application_start: Date.today, application_end: Date.tomorrow, confirmation_date: 12.days.from_now)
    get "/events/#{event.id}/applications/new"
    assert_response 200
    assert_select "h1", "Test Me #{I18n.l 13.days.from_now.to_date, format: :short} & #{I18n.l 2.weeks.from_now.to_date}"
  end

  test "Get an event before application starts" do
    event = create(:event, name: "Test Me", place: "Testing", installation_get_together_date: 13.days.from_now, scheduled_at: 2.weeks.from_now, application_start: 2.days.from_now, application_end: 10.days.from_now, confirmation_date: 12.days.from_now)
    get "/events/#{event.id}/applications/new"
    assert_response 200
    assert_select "h3", /Hi, early bird!/
  end

  test "Get an event after application ends" do
    event = create(:event, name: "Test Me", place: "Testing", installation_get_together_date: 13.days.from_now, scheduled_at: 2.weeks.from_now, application_start: 10.days.ago, application_end: 1.day.ago, confirmation_date: 5.days.from_now)
    get "/events/#{event.id}/applications/new"
    assert_response 200
    assert_select "p", /The application period for this workshop has already ended./
  end

  test "Trying to apply without providing all the requested data." do
    event = create(:event)
    post "/events/#{event.id}/applications", params: { application: {name: ""} }
    assert_response 200
    assert_select "h2", "Please check fields marked in red:"
  end

  test "Applying successfully." do
    event = create(:event)
    post "/events/#{event.id}/applications", params: { application: {female: 1, name: "Test Applicant", email: "some@test.de", level: "3", os: "Mac", language_en: 1, read_coc: 1} }
    assert_response 200
    assert_select "p", "Thank you for filling out the form!"
  end

  test "Trying to apply without providing all the requested data, the operating system field is preserved." do
    event = create(:event)
    post "/events/#{event.id}/applications", params: { application: {os: "mac"} }
    assert_response 200
    assert_select "option[selected]", "Mac"
  end
end
