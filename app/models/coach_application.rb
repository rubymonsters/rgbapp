class CoachApplication < ApplicationRecord
  belongs_to :coach
  belongs_to :event
  accepts_nested_attributes_for :coach
  accepts_nested_attributes_for :event
end
