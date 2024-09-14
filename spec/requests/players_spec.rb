# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Players API" do
  describe "POST /players" do
    it "creates a player" do
      expect do
        post "/players", params: { player: { name: "John Doe" } }
      end.to change(Player, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to match_json_schema(PlayerSchema.json_schema)
    end

    it "returns an error when player is invalid" do
      expect do
        post "/players", params: { player: { name: "" } }
      end.not_to change(Player, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to match_json_schema(ErrorSchema.json_schema)
    end
  end
end
