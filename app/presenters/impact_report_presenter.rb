# frozen_string_literal: true

class ImpactReportPresenter < ApplicationPresenter
  def to_hash
    {
      player_id: player.id,
      player_name: player.name,
      impact: player.impact
    }
  end
end
