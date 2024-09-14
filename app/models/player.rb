# frozen_string_literal: true

class Player < ApplicationRecord
  validates :name, presence: true
end
