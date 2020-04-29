class EventGroup < ApplicationRecord
  belongs_to :event
  has_and_belongs_to_many :coach_applications, join_table: "event_groups_coach_applications"
  has_and_belongs_to_many :applications, join_table: "event_groups_applications"
end
