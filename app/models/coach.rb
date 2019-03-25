class Coach < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  has_many :coach_applications
end
