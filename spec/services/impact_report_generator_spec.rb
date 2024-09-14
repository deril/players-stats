# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImpactReportGenerator do
  describe "#generate" do
    it "returns a list of players with their impact" do
      player1 = create(:player)
      player2 = create(:player)
      create(:playthrough, player: player1, score: 100)
      create(:playthrough, player: player1, score: 33)
      create(:playthrough, player: player2, score: 200)
      create(:playthrough, player: player2, score: 150)



      result = described_class.new.generate

      expect(result).to eq([ ImpactPlayer.new(player1.id, player1.name, 67), ImpactPlayer.new(player2.id, player2.name, 50) ])
    end
  end
end
