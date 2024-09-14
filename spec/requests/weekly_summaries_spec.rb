# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Weekly Summaries API" do
  describe "GET /weekly_summary" do
    it "returns a weekly summary" do
      player1 = create(:player)
      player2 = create(:player)
      create(:playthrough, player: player1, timestamp: Date.new(2020, 1, 1), score: 100, time_spent: 60)
      create(:playthrough, player: player1, timestamp: Date.new(2020, 1, 2), score: 200, time_spent: 120)
      create(:playthrough, player: player2, timestamp: Date.new(2020, 1, 1), score: 400, time_spent: 240)

      get "/weekly_summary", params: { week: 1, year: 2020 }

      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_schema(WeeklySummarySchema.json_schema)
    end
  end
end
