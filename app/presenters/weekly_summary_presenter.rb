# frozen_string_literal: true

class WeeklySummaryPresenter < ApplicationPresenter
  def to_hash
    {
      player_id: player.id,
      player_name: player.name,
      total_score: player.total_score,
      total_time_spent: player.total_time_spent
    }
  end
end
