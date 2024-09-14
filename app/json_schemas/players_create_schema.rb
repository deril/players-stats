# frozen_string_literal: true

Dry::Schema.load_extensions(:json_schema)

PlayersCreateSchema = Dry::Schema.JSON do
  required(:player).hash do
    required(:name).filled(:str?)
  end
end
