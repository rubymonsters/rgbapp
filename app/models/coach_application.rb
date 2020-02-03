class CoachApplication < ApplicationRecord
  belongs_to :coach
  belongs_to :event
  accepts_nested_attributes_for :coach
  accepts_nested_attributes_for :event

  scope :to_contact, -> { where(contacted_at: nil, state: :approved) }

  enum state: { pending: 0, approved: 1, rejected: 2, cancelled: 3 }

  def destroy
    update_attribute(:state, :cancelled)
  end
end
