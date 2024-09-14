# frozen_string_literal: true

Dry::Schema.load_extensions(:json_schema)

WeeklySummariesShowSchema = Dry::Schema.JSON do
  required(:week).filled(:int?)
  required(:year).filled(:int?)
  optional(:sort_by).maybe(:string)
end
