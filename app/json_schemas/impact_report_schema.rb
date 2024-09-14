# frozen_string_literal: true

Dry::Schema.load_extensions(:json_schema)

ImpactReportSchema = Dry::Schema.JSON do
  required(:impact_report).array(:hash) do
    required(:player_id).value(:integer, gt?: 0)
    required(:player_name).filled(:str?)
    required(:impact).value(:integer, gteq?: 0)
  end
end
