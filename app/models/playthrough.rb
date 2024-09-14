# frozen_string_literal: true

class Playthrough < ApplicationRecord
  belongs_to :player

  validates :timestamp, presence: true
  validates :score, presence: true
  validates :time_spent, presence: true
end
