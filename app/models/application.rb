class Application < ApplicationRecord
  validates :name,  :email, :level,  presence: true
  validates :email, uniqueness: true
  # validates :email, format: {with: @ , message}
   validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
   validates :os, presence: true, unless: :needs_computer?
   validate :at_least_select_one_language

   def at_least_select_one_language
     unless language_de? || language_en?
       errors.add(:language_de, "please select at least one language")
     end
   end
end
