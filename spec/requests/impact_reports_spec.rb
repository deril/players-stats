# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Impact Reports API" do
  describe "GET /impact_reports" do
    it "returns an impact report" do
      player1 = create(:player)
      player2 = create(:player)
      create(:playthrough, player: player1, timestamp: Date.new(2020, 1, 1), score: 100, time_spent: 60)
      create(:playthrough, player: player1, timestamp: Date.new(2020, 1, 2), score: 200, time_spent: 120)
      create(:playthrough, player: player2, timestamp: Date.new(2020, 1, 1), score: 400, time_spent: 240)

      get "/impact_report"

      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema(ImpactReportSchema.json_schema)
    end
  end
end
