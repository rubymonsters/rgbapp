require "csv"

class Application < ApplicationRecord
  validates :female, acceptance: { message: "You must identify as a woman or non-binary person to participate." }
  validates :name, presence: { message: "Please tell us your name." }
  validates :email, presence: { message: "Please enter your e-mail address." }
  validates :level, presence: { message: "Which level of coding do you have?" }
  validates :email, uniqueness: { scope: :event_id, message: "This e-mail address has already been used to apply for this workshop." }
  validates :email, email: { message: "This e-mail address is not valid." }
  validates :level, numericality: { message: "The level has to be a number from 0 to 10.", only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :os, presence: { message: "We need to know the operating system of your computer." }, unless: :needs_computer?
  validate :at_least_select_one_language
  validates :read_coc, acceptance: { message: "You must confirm that you have read the Code of Conduct and will comply with it." }
  validates :sequence_number, uniqueness: { scope: :event_id }, presence: true

  belongs_to :event

  scope :selected, -> { where(selected: true) }
  scope :rejected, -> { where(selected: false) }
  scope :not_marked_as_selected, -> { where(selected_on: nil) }
  scope :confirmed, -> { where(attendance_confirmed: true) }

   def at_least_select_one_language
     unless language_de? || language_en?
       errors.add(:language, "Please select at least one language.")
     end
   end

   def self.to_csv(options = {})
     CSV.generate(options) do |csv|
       csv << ["Name", "E-mail", "English", "German", "Attended before", "Rejected before", "Level", "Operating system", "Needs computer", "Date of application", "Comments"]
       all.each do |application|
         csv << [application.name, application.email, I18n.t(application.language_en.class), I18n.t(application.language_de.class), I18n.t(application.attended_before.class), I18n.t(application.rejected_before.class), application.level, application.os, I18n.t(application.needs_computer.class), application.created_at, application.comments]
       end
     end
   end
end
