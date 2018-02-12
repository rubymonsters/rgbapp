require "application_system_test_case"

class ConfirmAttendanceTest < ApplicationSystemTestCase

  test "confirmation" do
    @event = create(:event)
    @applicant = create(:application, event: @event, selected: true, selected_on: Date.today, attendance_confirmed: false)

    visit "/events/#{@event.id}/applications/#{@applicant.random_id}/confirm"

    assert_text "Thanks for confirming!"

    assert @applicant.reload.attendance_confirmed?
  end

  test "confirmation too late" do
    @event = create(:event)
    @applicant = create(:application, event: @event, selected: true, selected_on: 2.weeks.ago, attendance_confirmed: false)

    visit "/events/#{@event.id}/applications/#{@applicant.random_id}/confirm"

    assert_no_text "Thanks for confirming!"

    assert !@applicant.reload.attendance_confirmed?
  end

  test "confirmation if not selected" do
    @event = create(:event)
    @applicant = create(:application, event: @event, selected: false, attendance_confirmed: false)

    assert_raises ActiveRecord::RecordNotFound do
      visit "/events/#{@event.id}/applications/#{@applicant.random_id}/confirm"
    end

    assert !@applicant.reload.attendance_confirmed?
  end

  test "confirmation without valid random id" do
    @event = create(:event)
    @applicant = create(:application, event: @event, selected: true, selected_on: Date.today, attendance_confirmed: false)

    assert_raises ActiveRecord::RecordNotFound do
      visit "/events/#{@event.id}/applications/aklfphgh/confirm"
    end

    assert !@applicant.reload.attendance_confirmed?
  end
end
