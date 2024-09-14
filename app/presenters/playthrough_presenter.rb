# frozen_string_literal: true

class PlaythroughPresenter < ApplicationPresenter
  def to_hash
    {
      id: playthrough.id,
      player_id: playthrough.player_id,
      started_at: playthrough.started_at.iso8601,
      score: playthrough.score,
      time_spent: playthrough.time_spent
    }
  end
end
