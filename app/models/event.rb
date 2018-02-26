class Event < ApplicationRecord
  has_many :applications

  validates :name, :place, :scheduled_at, :application_start, :application_end, :confirmation_date, :start_time, :end_time, presence: true

  def self.send_reminders
    Event.where(scheduled_at: 2.days.from_now.to_date.all_day).each do |event|
      event.applications.where(selected: true, attendance_confirmed: true). each do |application|
        UserMailer.reminder_mail(application).deliver_now
      end
    end
  end
end
