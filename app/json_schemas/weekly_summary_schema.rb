# frozen_string_literal: true

Dry::Schema.load_extensions(:json_schema)

WeeklySummarySchema = Dry::Schema.JSON do
  required(:weekly_summary).array(:hash) do
    required(:player_id).value(:integer, gt?: 0)
    required(:player_name).filled(:str?)
    required(:total_score).value(:integer, gteq?: 0)
    required(:total_time_spent).value(:integer, gteq?: 0)
  end
end
