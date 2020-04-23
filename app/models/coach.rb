class Coach < ApplicationRecord
  GENDERS = [:female, :male, :other, :prefer_not_to_say]
  belongs_to :user
  accepts_nested_attributes_for :user
  has_many :coach_applications
  has_and_belongs_to_many :event_groups
end
