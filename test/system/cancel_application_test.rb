require "application_system_test_case"

class CancelApplicationTest < ApplicationSystemTestCase
  test "Cancellation" do
    @event = create(:event)
    @applicant = create(:application, event: @event, state: :application_selected, selected_on: 5.days.ago)

    visit "/events/#{@event.id}/applications/#{@applicant.random_id}/cancel"

    assert_text "Thank you for letting us know!"

    assert @applicant.reload.cancelled?
    assert !@applicant.attendance_confirmed?
  end

  test "cancellation if not selected" do
    @event = create(:event)
    @applicant = create(:application, event: @event, state: :waiting_list)

    assert_raises ActiveRecord::RecordNotFound do
      visit "/events/#{@event.id}/applications/#{@applicant.random_id}/cancel"
    end

    assert !@applicant.reload.cancelled?
  end

  test "confirmation without valid random id" do
    @event = create(:event)
    @applicant = create(:application, event: @event, state: :application_selected, selected_on: Date.today)

    assert_raises ActiveRecord::RecordNotFound do
      visit "/events/#{@event.id}/applications/aklfphgh/cancel"
    end

    assert !@applicant.reload.cancelled?
    assert !@applicant.attendance_confirmed?
  end

  teardown do
    Timecop.return
  end
end
