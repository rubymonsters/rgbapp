require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "Get an event that does not exist responds to 404" do
    assert_raises ActiveRecord::RecordNotFound do
      get "/events/5/applications/new"
    end
  end

  test "Get an event that exists respond to 200" do
    event = Event.create(name: "Test Me", place: "Testing", scheduled_at: "2017-09-25", application_start: Time.now, application_end: 10.days.from_now, confirmation_date: Time.now)
    get "/events/#{event.id}/applications/new"
    assert_response 200
    assert_select "h1", "Test Me 25.09.2017"
  end

  test "Get an event before application starts" do
    event = Event.create(name: "Test Me", place: "Testing", scheduled_at: "2017-09-25", application_start: 2.days.from_now, application_end: 10.days.from_now, confirmation_date: 5.days.from_now)
    get "/events/#{event.id}/applications/new"
    assert_response 200
    assert_select "TOO EARLY! THE APPLICATION HASN'T STARTED YET!"
  end

  test "Get an event after application ends" do
    event = Event.create(name: "Test Me", place: "Testing", scheduled_at: "2017-09-25", application_start: 10.days.ago, application_end: 1.day.ago, confirmation_date: 5.days.from_now)
    get "/events/#{event.id}/applications/new"
    assert_response 200
    assert_select "TOO LATE! THE APPLICATION TIME IS OVER!"
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
