# frozen_string_literal: true

module Helpers
  module Request
    def response_body
      JSON.parse(response.body)
    end

    def post_json(path, body)
      post path, params: body.to_json, headers: { "Content-Type" => "application/json" }
    end
  end
end
