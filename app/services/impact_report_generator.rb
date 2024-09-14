# frozen_string_literal: true

class ImpactReportGenerator
  def generate
    players = Player.joins(:playthroughs)
                    .select("players.*, MIN(playthroughs.score) as first_score, MAX(playthroughs.score) as best_score")
                    .group("players.id")
                    .map { |player| { player: player, impact: player.best_score - player.first_score } }
                    .sort_by { |player| -player[:impact] }

    players.map do |player|
      ImpactPlayer.new(player[:player].id, player[:player].name, player[:impact])
    end
  end
end
