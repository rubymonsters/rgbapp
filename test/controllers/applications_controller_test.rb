require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "Get an event that does not exist responds to 404" do
    assert_raises ActiveRecord::RecordNotFound do
      get "/events/5/applications/new"
    end
  end

  test "Get an event that exists respond to 200" do
    event = create(:event, name: "Test Me", scheduled_at: "2017-09-25")
    get "/events/#{event.id}/applications/new"
    assert_response 200
    assert_select "h1", "Test Me 25.09.2017"
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
end
