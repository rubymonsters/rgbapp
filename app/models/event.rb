class Event < ApplicationRecord
  has_many :applications

  validates :name, :place, :scheduled_at, :application_start, :application_end, :confirmation_date, :start_time, :end_time, presence: true 
end
