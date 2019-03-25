require "application_system_test_case"

class ConfirmAttendanceTest < ApplicationSystemTestCase

  test "confirmation" do
    @event = create(:event)
    @applicant = create(:application, event: @event, state: :application_selected, selected_on: 5.days.ago, attendance_confirmed: false)

    visit "/events/#{@event.id}/applications/#{@applicant.random_id}/confirm"

    assert_text "Thanks for confirming!"

    assert @applicant.reload.attendance_confirmed?
  end

  test "confirmation too late" do
    @event = create(:event)
    @applicant = create(:application, event: @event, state: :application_selected, selected_on: 6.days.ago, attendance_confirmed: false)

    visit "/events/#{@event.id}/applications/#{@applicant.random_id}/confirm"

    assert_no_text "Thanks for confirming!"

    assert !@applicant.reload.attendance_confirmed?
  end

	test "confirmation after deadline" do
    @event = create(:event, confirmation_deadline: 3)
    @applicant = create(:application, event: @event, state: :application_selected, selected_on: 4.days.ago, attendance_confirmed: false)

    visit "/events/#{@event.id}/applications/#{@applicant.random_id}/confirm"

    assert_no_text "Thanks for confirming!"

    assert !@applicant.reload.attendance_confirmed?
  end

  test "confirmation after midnight" do
    Timecop.freeze("2018-07-31 00:01 CEST")
    @event = create(:event)
    @applicant = create(:application, event: @event, state: :application_selected, selected_on: "2018-07-25", attendance_confirmed: false)

    visit "/events/#{@event.id}/applications/#{@applicant.random_id}/confirm"

    assert_no_text "Thanks for confirming!"

    assert !@applicant.reload.attendance_confirmed?
  end


  test "confirmation if not selected" do
    @event = create(:event)
    @applicant = create(:application, event: @event, state: :waiting_list, attendance_confirmed: false)

    visit "/events/#{@event.id}/applications/#{@applicant.random_id}/confirm"

    assert_text "The page you were looking for doesn't exist"
    assert !@applicant.reload.attendance_confirmed?
  end

  test "confirmation without valid random id" do
    @event = create(:event)
    @applicant = create(:application, event: @event, state: :application_selected, selected_on: Date.today, attendance_confirmed: false)

    visit "/events/#{@event.id}/applications/aklfphgh/confirm"

    assert_text "The page you were looking for doesn't exist"
    assert !@applicant.reload.attendance_confirmed?
  end

  teardown do
    Timecop.return
  end
end
