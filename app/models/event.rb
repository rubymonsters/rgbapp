class Event < ApplicationRecord
  has_many :applications

  validates :name, :place, :scheduled_at, :application_start, :application_end, :confirmation_date, :start_time, :end_time, presence: true
  validate :right_order_of_dates

  def self.send_reminders
    Event.where(scheduled_at: 2.days.from_now.to_date.all_day).each do |event|
      event.applications.where(selected: true, attendance_confirmed: true). each do |application|
        UserMailer.reminder_mail(application).deliver_now
      end
    end
  end

  def right_order_of_dates
    dates = [application_start, application_end, confirmation_date, scheduled_at]
    if dates != dates.sort
      errors.add(:scheduled_at, "Dates aren't in the right order.")
    end
  end

end
