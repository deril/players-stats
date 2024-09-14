# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  RSpec::Matchers.define :match_json_schema do |json_schema, validation_opts = {}|
    match do |response|
      JSON::Validator.fully_validate(json_schema, response, validation_opts).empty?
    end
    failure_message do |response|
      +"expected that #{response} would match JSON schema #{json_schema}\n" +
      JSON::Validator.fully_validate(json_schema, response, validation_opts).join("\n")
    end
  end
end
