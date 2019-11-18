class CoachApplication < ApplicationRecord
  belongs_to :coach
  belongs_to :event
  accepts_nested_attributes_for :coach
  accepts_nested_attributes_for :event

  scope :pending, -> { where(state: :pending) }
  scope :approved, -> { where(state: :approved) }
  scope :rejected, -> { where(state: :rejected) }
  scope :cancelled, -> { where(state: :cancelled) }

  enum state: { pending: 0, approved: 1, rejected: 2, cancelled: 3 }
end
