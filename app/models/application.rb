class Application < ApplicationRecord
  validates :female, acceptance: { message: "You must identify as a woman or non-binary person to participate." }
  validates :name, presence: { message: "Please tell us your name." }
  validates :email, presence: { message: "Please enter your e-mail address." }
  validates :level, presence: { message: "Which level of coding do you have?" }
  validates :email, uniqueness: { message: "This e-mail address has already been used to apply for this workshop." }
  validates :email, email: { message: "This e-mail address is not valid." }
  validates :level, numericality: { message: "The level has to be a number from 0 to 10.", only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :os, presence: { message: "We need to know the operating system of your computer." }, unless: :needs_computer?
  validate :at_least_select_one_language
  validates :read_coc, acceptance: { message: "You must confirm that you have read the Code of Conduct and will comply with it." }

  belongs_to :event

   def at_least_select_one_language
     unless language_de? || language_en?
       errors.add(:language, "Please select at least one language.")
     end
   end
end
