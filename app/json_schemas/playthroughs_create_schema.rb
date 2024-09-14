# frozen_string_literal: true

Dry::Schema.load_extensions(:json_schema)

PlaythroughsCreateSchema = Dry::Schema.JSON do
  required(:playthrough).hash do
    required(:player_id).value(:integer, gt?: 0)
    required(:started_at).value(:date_time)
    required(:score).value(:integer, gteq?: 0)
    required(:time_spent).value(:integer, gteq?: 0)
  end
end
