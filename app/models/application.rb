class Application < ApplicationRecord
  validates :name,  :email, :level,  presence: true
  validates :email, uniqueness: true
  # validates :email, format: {with: @ , message}
   validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end
