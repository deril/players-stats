# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Playthroughs API" do
  describe "POST /playthroughs" do
    it "creates a playthrough" do
      player = FactoryBot.create(:player)
      expect do
        post "/playthroughs", params: { playthrough: { player_id: player.id, started_at: 2.years.ago.iso8601, score: 100, time_spent: 60 } }
      end.to change(Playthrough, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to match_json_schema(PlaythroughSchema.json_schema)
    end

    it "returns an error when player is invalid" do
      expect do
        post "/playthroughs", params: { playthrough: { player_id: 0, started_at: 2.years.ago.iso8601, score: 100, time_spent: 60 } }
      end.not_to change(Playthrough, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body["player"]).to include("must exist")
    end
  end
end
