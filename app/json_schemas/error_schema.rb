# frozen_string_literal: true

Dry::Schema.load_extensions(:json_schema)

ErrorSchema = Dry::Schema.JSON do
  required(:errors).array(:hash) do
    required(:text).filled(:str?)
    required(:path).array(:str?)
    required(:predicate).filled(:str?)
    required(:args) { array(:str?) | array(:int?) }
    required(:input) { str? | int? }
    required(:meta).value(:hash)
  end
end
