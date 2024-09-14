# frozen_string_literal: true

require "rails_helper"

RSpec.describe WeeklySummariesShowAction do
  let(:weekly_summary_generator) { instance_double(WeeklySummaryGenerator, generate: summary) }
  let(:summary_player) { Struct.new(:id, :name, :total_score, :total_time_spent) }
  let(:summary) do
    [
      SummaryPlayer.new(1, "John Doe", 100, 1000),
      SummaryPlayer.new(2, "Jane Doe", 200, 2000),
      SummaryPlayer.new(3, "Foo Bar", 300, 3000)
    ]
  end

  before do
    allow(WeeklySummaryGenerator).to receive(:new).and_return(weekly_summary_generator)
  end

  describe "#call" do
    let(:action) { described_class.new(week: 1, year: 2020) }

    it "returns a weekly summary" do
      result = action.call

      expect(result[:weekly_summary]).to all(be_a(WeeklySummaryPresenter))
      expect(result[:weekly_summary].map(&:to_hash)).to eq([
        { player_id: 1, player_name: "John Doe", total_score: 100, total_time_spent: 1000 },
        { player_id: 2, player_name: "Jane Doe", total_score: 200, total_time_spent: 2000 },
        { player_id: 3, player_name: "Foo Bar", total_score: 300, total_time_spent: 3000 }
      ])
    end

    it "calls the summary generator with correct parameters" do
      action.call

      expect(weekly_summary_generator).to have_received(:generate).with(week: 1, year: 2020, sort_by: nil)
    end

    it "caches the result" do
      cache_key = "weekly_summaries/2020/1/default"
      expect(Rails.cache).to receive(:fetch).with(cache_key, expires_in: Rails.application.config.weekly_summary_cache_ttl).and_call_original

      action.call
    end
  end
end
