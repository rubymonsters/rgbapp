class Event < ApplicationRecord
  has_many :applications
  has_many :coach_applications
  before_create :copy_templates

  validates :name, :place, :scheduled_at, :application_start, :application_end, :confirmation_date, :start_time, :end_time, presence: true
  validate :right_order_of_dates

  def self.send_reminders
    Event.where("scheduled_at - current_date = reminder_date").each do |event|
      event.applications.where(state: :application_selected, attendance_confirmed: true).each do |application|
        UserMailer.reminder_mail(application).deliver_now
      end
    end
    Event.where("scheduled_at = current_date + 1 + confirmation_deadline").each do |event|
      event.applications.where(state: :application_selected, attendance_confirmed: false).each do |application|
        UserMailer.reminder_attendance_mail(application).deliver_now
      end
    end
  end

  attr_accessor :copy_templates_from_event_id

  def name_and_date
    scheduled_at.to_s + " " + name
  end

private

  def right_order_of_dates
    dates = [application_start, application_end, confirmation_date, scheduled_at]
    if dates != dates.sort
      errors.add(:scheduled_at, "Dates aren't in the right order.")
    end
  end

  def copy_templates
    unless copy_templates_from_event_id.blank?
      event = Event.find(copy_templates_from_event_id)
      self.application_mail = event.application_mail
      self.selection_mail = event.selection_mail
      self.rejection_mail = event.rejection_mail
      self.waiting_list_mail = event.waiting_list_mail
      self.reminder_mail = event.reminder_mail
      self.application_mail_subject = event.application_mail_subject
      self.selection_mail_subject = event.selection_mail_subject
      self.rejection_mail_subject = event.rejection_mail_subject
      self.waiting_list_mail_subject = event.waiting_list_mail_subject
      self.reminder_mail_subject = event.reminder_mail_subject
      self.reminder_attendance_mail = event.reminder_attendance_mail
      self.reminder_attendance_mail_subject = event.reminder_attendance_mail_subject
      self.coach_approval_mail = event.coach_approval_mail
      self.coach_approval_mail_subject = event.coach_approval_mail_subject
    end
  end
end
