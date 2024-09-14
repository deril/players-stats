# frozen_string_literal: true

Dry::Schema.load_extensions(:json_schema)

PlayerSchema = Dry::Schema.JSON do
  required(:id).filled(:int?)
  required(:name).filled(:str?)
end
