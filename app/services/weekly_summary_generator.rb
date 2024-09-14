# frozen_string_literal: true

class WeeklySummaryGenerator
  def generate(week:, year:, sort_by: nil)
    start_date = Date.commercial(year, week, 1)
    end_date = Date.commercial(year, week, 7)
    players = Player.joins(:playthroughs)
                    .where(playthroughs: { timestamp: start_date..end_date })
                    .select("players.*, SUM(playthroughs.score) as total_score, SUM(playthroughs.time_spent) as total_time_spent")
                    .group("players.id")
                    .order(sort_by || :id)

    players.map do |player|
      SummaryPlayer.new(player.id, player.name, player.total_score, player.total_time_spent)
    end
  end
end
