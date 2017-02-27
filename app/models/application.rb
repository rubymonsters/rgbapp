class Application < ApplicationRecord
  validates :name, :email, presence: {message: 'Bitte ausfüllen!!!'}
  validates :language_en, :language_de, presence: {message: '?'}
  validates :comments, :level, :os, presence: {message: 'Bitte ausfüllen!!!'}
end
