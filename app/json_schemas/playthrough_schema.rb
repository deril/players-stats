# frozen_string_literal: true

Dry::Schema.load_extensions(:json_schema)

PlaythroughSchema = Dry::Schema.JSON do
  required(:id).filled(:int?)
  required(:player_id).filled(:int?)
  required(:timestamp).filled(:date_time?)
  required(:score).filled(:int?)
  required(:time_spent).filled(:int?)
end
